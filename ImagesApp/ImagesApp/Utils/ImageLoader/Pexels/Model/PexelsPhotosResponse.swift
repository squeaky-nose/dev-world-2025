//
//  PexelsPhotosResponse.swift
//  PexelsPhotos
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


struct PexelsPhotosResponse: Decodable {
    let page: Int
    let perPage: Int
    let photos: [PexelsPhoto]
    let nextPage: String?
}
