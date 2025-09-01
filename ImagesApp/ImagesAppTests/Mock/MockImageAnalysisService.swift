//
//  MockImageAnalysisService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp
import Foundation

final class MockImageAnalysisService: ImageAnalysisService {

    var shouldFail: Bool = false

    func analyseImage(imageUrl: String) async throws -> String {
        if shouldFail {
            throw NSError(domain: "unit test error", code: 0, userInfo: nil)
        }

        return "Unit test analysis"
    }
}
