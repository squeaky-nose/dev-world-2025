//
//  OpenAIImageAnalysisService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


import Foundation

final class OpenAIImageAnalysisService: ImageAnalysisService {

    private enum Model: String {
        case gpt5 = "gpt-5"
        case gpt4oMini = "gpt-4o-mini"
    }

    private let analysisPrompt = "Describe this photo like alt text, then list notable objects. Ensure response is formatted plain text. Dont tell me its alt text."

    func analyseImage(imageUrl: String) async throws -> String {
        guard let config = OpenAI.loadConfig()
        else { fatalError("Missing OpenAI.plist with key apiKey") }

        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/responses")!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Payload for a multimodal turn: text + image URL
        // The Responses API expects `input` to be an array of message turns.
        let body: [String: Any] = [
            "model": Model.gpt5.rawValue,
            "input": [[
                "role": "user",
                "content": [
                    ["type": "input_text", "text": analysisPrompt],
                    ["type": "input_image", "image_url": imageUrl]
                ]
            ]]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) == false {
            // Handy to print response body while debugging:
            // print(String(data: data, encoding: .utf8) ?? "—")
            throw AnalysisError.badURLResponse(http.statusCode)
        }

        // The Responses API returns a convenience `output_text` field when your result is text.
        // We'll try that first, then fall back to stitching text from the structured output.
        struct ResponsesEnvelope: Decodable {
            let output_text: String?
            // Minimal fallback shape:
            struct OutputItem: Decodable { let content: [Block]? }
            struct Block: Decodable {
                let type: String
                let text: String?
            }
            let output: [OutputItem]?
        }

        let decoded = try JSONDecoder().decode(ResponsesEnvelope.self, from: data)
        if let text = decoded.output_text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            return text
        }

        // Fallback: gather any text blocks
        let stitched = (decoded.output ?? [])
            .flatMap { $0.content ?? [] }
            .compactMap { $0.text }
            .joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard stitched.isEmpty == false else { throw AnalysisError.noTextInResponse }
        return stitched
    }
}
