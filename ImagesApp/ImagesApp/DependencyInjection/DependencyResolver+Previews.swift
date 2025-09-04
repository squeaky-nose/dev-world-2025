//
//  DependencyResolver+Previews.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

#if DEBUG
extension DependencyResolver {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        resolver.logger.info("Setting up forPreview resolver")
        resolver.register(ImageLoader.self, resolved: .perResolution) { _ in
            PreviewImageLoader()
        }
        resolver.register(ImageFavouritesService.self, resolved: .singleton) { _ in
            let favourites = InMemoryImageFavourites()

//            favourites.save(.init(id: 1076758,
//                                  width: 3230,
//                                  height: 3648,
//                                  alt: "Close-up of a vibrant jellyfish gracefully swimming in the clear waters of Illes Balears, Spain.",
//                                  photographer: "Pawel Kalisinski",
//                                  src: PexelsPhoto.Src(
//                                    original: "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg",
//                                    large: "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
//                                    medium: "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg?auto=compress&cs=tinysrgb&h=350",
//                                    small: "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg?auto=compress&cs=tinysrgb&h=130"
//                                  )))

            return favourites
        }
        resolver.register(ImageAnalysisService.self, resolved: .perResolution) { _ in
            PreviewImageAnalysisService()
        }
        return resolver
    }
}
#endif
