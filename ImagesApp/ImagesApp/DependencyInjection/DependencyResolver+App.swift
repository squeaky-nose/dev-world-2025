//
//  DependencyResolver+App.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

extension DependencyResolver {
    /// For the app
    static func forApp() -> DependencyResolver {
        let resolver = DependencyResolver.createEmpty()
        resolver.logger.info("Setting up forApp resolver")
        resolver.register(ImageLoader.self, resolved: .perResolution) { _ in
            OnlineImageLoader()
        }
        resolver.register(ImageFavouritesService.self, resolved: .singleton) { _ in
            DefaultsImageFavouritesService()
        }
        resolver.register(ImageAnalysisService.self, resolved: .perResolution) { _ in
            OpenAIImageAnalysisService()
        }
        return resolver
    }
}
