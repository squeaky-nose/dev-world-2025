//
//  MockSuspendedImageLoader.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp

class MockSuspendedImageLoader: ImageLoader {
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
        continuationResults = searchResults
        return await withCheckedContinuation { cont in
            continuation = cont
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
                         small: "http://example.com/medium3curated.jpg"))
    ]
    func curated() async throws -> [PexelsPhoto] {
        curatedCount += 1
        continuationResults = curatedResults
        return await withCheckedContinuation { cont in
            continuation = cont
        }
    }

    private var continuation: CheckedContinuation<[PexelsPhoto], Never>?
    private var continuationResults: [PexelsPhoto]? = nil
    func resume() {
        guard let results = continuationResults
        else { return }

        continuation?.resume(returning: results)

        continuationResults = nil
        continuation = nil
    }
}
