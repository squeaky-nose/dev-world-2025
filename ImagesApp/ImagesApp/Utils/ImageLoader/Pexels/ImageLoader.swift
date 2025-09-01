//
//  ImageLoader.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation
import OSLog

protocol ImageLoader {
    var logger: Logger { get }

    func search(query: String) async throws -> [PexelsPhoto]
    func curated() async throws -> [PexelsPhoto]
}

extension ImageLoader {
    func decodeResponse(from data: Data) throws -> [PexelsPhoto] {
        logger.info("Decoding response")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(PexelsPhotosResponse.self,
                                         from: data)
        logger.info("Read \(decoded.photos.count) photos")
        return decoded.photos
    }
}
