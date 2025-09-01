//
//  OnlineImageLoader.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation


class OnlineImageLoader: ImageLoader {

    let logger = AutoLogger.unifiedLogger()

    let pexelsAPI = PexelsAPI.loadConfig()

    init() {
        logger.info("Created OnlineImageLoader")
    }

    func search(query: String) async throws -> [PexelsPhoto] {
        guard let pexelsAPI = pexelsAPI else {
            fatalError("Unable to parse API configuration")
        }

        logger.info("Performing network request for search")
        var urlComponents = URLComponents(string: pexelsAPI.searchEndpoint)! //FIXME: Handle/remove bang
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: "\(query)")
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.setValue(pexelsAPI.apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request) //FIXME: Handle/remove bang

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try decodeResponse(from: data)
    }

    func curated() async throws -> [PexelsPhoto] {
        guard let pexelsAPI = pexelsAPI else {
            fatalError("Unable to parse API configuration")
        }

        logger.info("Performing network request for curated")
        let urlComponents = URLComponents(string: pexelsAPI.curatedEndpoint)! //FIXME: Handle/remove bang

        var request = URLRequest(url: urlComponents.url!)
        request.setValue(pexelsAPI.apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request) //FIXME: Handle/remove bang

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try decodeResponse(from: data)
    }
}
