//
//  ImageFavouritesService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

protocol ImageFavouritesService {
    func contains(imageId: Int) -> Bool

    func savedImages() async -> [PexelsPhoto]

    func save(_ image: PexelsPhoto)

    func remove(_ imageId: Int)
}
