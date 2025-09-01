//
//  InMemoryImageFavourites.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


class InMemoryImageFavourites: ImageFavouritesService {
    internal var images: [PexelsPhoto] = []

    func savedImages() async -> [PexelsPhoto] {
        images
    }

    func contains(imageId: Int) -> Bool {
        images.contains { $0.id == imageId }
    }
    
    func save(_ image: PexelsPhoto) {
        remove(image.id)
        images.append(image)
    }

    func remove(_ imageId: Int) {
        images.removeAll { $0.id == imageId }
    }
}
