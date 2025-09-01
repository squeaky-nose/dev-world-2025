//
//  PexelsAPI.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

struct PexelsAPI: Codable {
    let apiKey: String
    let searchEndpoint: String
    let curatedEndpoint: String

    static func loadConfig() -> PexelsAPI? {
        if let url = Bundle.main.url(forResource: "PexelsAPI", withExtension: "plist"),
           let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            return try? decoder.decode(PexelsAPI.self, from: data)
        }
        return nil
    }
}
