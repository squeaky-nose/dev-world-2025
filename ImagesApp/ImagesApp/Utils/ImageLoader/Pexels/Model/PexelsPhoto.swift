//
//  PexelsPhoto.swift
//  PexelsPhotos
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


struct PexelsPhoto: Codable, Identifiable, Hashable {
    struct Src: Codable, Hashable {
        let original: String
        let large: String
        let medium: String
        let small: String
    }

    let id: Int
    let width: Int
    let height: Int
    let alt: String
    let photographer: String
    let src: Src
}
