//
//  ImageAnalysisService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

public enum AnalysisError: Error {
    case badURLResponse(Int)
    case noTextInResponse
}

protocol ImageAnalysisService {
    func analyseImage(imageUrl: String) async throws -> String
}
