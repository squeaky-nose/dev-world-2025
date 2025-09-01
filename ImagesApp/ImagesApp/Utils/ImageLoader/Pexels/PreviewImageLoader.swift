//
//  PreviewImageLoader.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation


class PreviewImageLoader: ImageLoader {

    let logger = AutoLogger.unifiedLogger()
    
    init() {
        logger.info("Created PreviewImageLoader")
    }
    
    func search(query: String) async throws -> [PexelsPhoto] {
        try await Task.sleep(for: .seconds(1))

        let data = try Data(contentsOf: PreviewContentFile.searchForPhotoMaldives.url)
        return try decodeResponse(from: data)
    }

    func curated() async throws -> [PexelsPhoto] {
        try await Task.sleep(for: .seconds(1))

        let data = try Data(contentsOf: PreviewContentFile.curatedNetworkResponse.url)
        return try decodeResponse(from: data)
    }
}
