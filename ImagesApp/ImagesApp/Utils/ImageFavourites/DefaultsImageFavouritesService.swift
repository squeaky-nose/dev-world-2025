//
//  DefaultsImageFavouritesService.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

final class DefaultsImageFavouritesService: InMemoryImageFavourites {

    private let defaults: UserDefaults
    private let DefaultsKey = "favoriteImages"

    override init () {
        defaults = UserDefaults(suiteName: "DefaultsImageFavouritesService")!
        super.init()

        readDefaults()
    }

    private func readDefaults() {
        guard let stringData = defaults.data(forKey: DefaultsKey)
        else { return }

        if let decoded = try? JSONDecoder().decode([PexelsPhoto].self, from: stringData) {
            images = decoded
        }
    }

    private func writeDefaults() {
        guard let encoded = try? JSONEncoder().encode(images)
        else { return }
        
        defaults.set(encoded, forKey: DefaultsKey)
    }

    override func save(_ image: PexelsPhoto) {
        super.save(image)
        writeDefaults()
    }
    
    override func remove(_ imageId: Int) {
        super.remove(imageId)
        writeDefaults()
    }
}
