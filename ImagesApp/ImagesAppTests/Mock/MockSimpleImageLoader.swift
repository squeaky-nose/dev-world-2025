//
//  MockSimpleImageLoader.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp

class MockSimpleImageLoader: ImageLoader {
    var logger = AutoLogger.unifiedLogger()

    var totalCalls: UInt { searchCount + curatedCount}

    var searchCount: UInt = 0
    var searchResults: [PexelsPhoto] = [
        .init(id: 1, width: 11, height: 111, alt: "stub search 1", photographer: "photographer 1",
              src: .init(original: "http://example.com/original1search.jpg",
                         large: "http://example.com/large1search.jpg",
                         medium: "http://example.com/medium1search.jpg",
                         small: "http://example.com/medium1search.jpg")),
        .init(id: 2, width: 22, height: 222, alt: "stub search 2", photographer: "photographer 2",
              src: .init(original: "http://example.com/original2search.jpg",
                         large: "http://example.com/large2search.jpg",
                         medium: "http://example.com/medium2search.jpg",
                         small: "http://example.com/medium2search.jpg")),
        .init(id: 3, width: 33, height: 333, alt: "stub search 3", photographer: "photographer 3",
              src: .init(original: "http://example.com/original3search.jpg",
                         large: "http://example.com/large3search.jpg",
                         medium: "http://example.com/medium3search.jpg",
                         small: "http://example.com/medium3search.jpg"))
    ]

    func search(query: String) async throws -> [PexelsPhoto] {
        searchCount += 1
        return await withCheckedContinuation { cont in
            cont.resume(returning: searchResults)
        }
    }

    var curatedCount: UInt = 0
    var curatedResults: [PexelsPhoto] = [
        .init(id: 1, width: 11, height: 111, alt: "stub curated 1", photographer: "photographer 1",
              src: .init(original: "http://example.com/original1curated.jpg",
                         large: "http://example.com/large1curated.jpg",
                         medium: "http://example.com/medium1curated.jpg",
                         small: "http://example.com/medium1curated.jpg")),
        .init(id: 2, width: 22, height: 222, alt: "stub curated 2", photographer: "photographer 2",
              src: .init(original: "http://example.com/original2curated.jpg",
                         large: "http://example.com/large2curated.jpg",
                         medium: "http://example.com/medium2curated.jpg",
                         small: "http://example.com/medium2curated.jpg")),
        .init(id: 3, width: 33, height: 333, alt: "stub curated 3", photographer: "photographer 3",
              src: .init(original: "http://example.com/original3curated.jpg",
                         large: "http://example.com/large3curated.jpg",
                         medium: "http://example.com/medium3curated.jpg",
                         small: "http://example.com/medium3curated.jpg")),
        .init(id: 4, width: 44, height: 444, alt: "stub curated 4", photographer: "photographer 4",
              src: .init(original: "http://example.com/original4curated.jpg",
                         large: "http://example.com/large4curated.jpg",
                         medium: "http://example.com/medium4curated.jpg",
                         small: "http://example.com/medium4curated.jpg"))
    ]
    func curated() async throws -> [PexelsPhoto] {
        curatedCount += 1
        return await withCheckedContinuation { cont in
            cont.resume(returning: curatedResults)
        }
    }
}
