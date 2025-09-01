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
            InMemoryImageFavourites()
        }
        resolver.register(ImageAnalysisService.self, resolved: .perResolution) { _ in
            PreviewImageAnalysisService()
        }
        return resolver
    }
}
#endif
