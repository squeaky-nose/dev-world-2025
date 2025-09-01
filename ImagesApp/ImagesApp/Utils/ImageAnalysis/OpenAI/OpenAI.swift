//
//  PexelsAPI.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

struct OpenAI: Codable {
    let apiKey: String

    static func loadConfig() -> OpenAI? {
        if let url = Bundle.main.url(forResource: "OpenAI", withExtension: "plist"),
           let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            return try? decoder.decode(OpenAI.self, from: data)
        }
        return nil
    }
}
