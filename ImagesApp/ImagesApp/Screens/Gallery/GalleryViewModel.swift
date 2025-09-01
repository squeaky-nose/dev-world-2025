//
//  GalleryViewModel.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

final class GalleryViewModel: ObservableObject {

    enum Mode: Equatable {
        case search(String)
        case saved
        case curated

        static func ==(lhs: Mode, rhs: Mode) -> Bool {
            switch (lhs, rhs) {
            case let (.search(lhsQuery), .search(rhsQuery)):
                return lhsQuery == rhsQuery
            case (.saved, .saved):
                return true
            case (.curated, .curated):
                return true
            default:
                return false
            }
        }
    }

    let logger = AutoLogger.unifiedLogger()

    var coordinator: Coordinator
    let mode: Mode
    let pageTitle: String

    let imageLoader: ImageLoader
    @Published var isLoading = false

    @Published var loadingText: LocalizedStringResource = "galary.loading.text"
    @Published var noImagesText: LocalizedStringResource = "gallery.results.none"
    let noImagesSystemImage = SFSymbol.cameraMacroSlash

    @Published var photos: [PexelsPhoto] = []
    @Published var selectedPhoto: PexelsPhoto?

    @Published var toggleFavouriteButton: LocalizedStringResource = "galary.favourite.toggle"

    let imageFavouritesService: ImageFavouritesService

    init(_ coordinator: Coordinator, mode: Mode) {
        self.coordinator = coordinator
        self.mode = mode
        switch mode {
        case let .search(query):
            pageTitle = "\(query)"
        case .curated:
            pageTitle = LocalizedStringResource(stringLiteral: "galary.title.curated").string
        case .saved:
            pageTitle = LocalizedStringResource(stringLiteral: "galary.title.saved").string
        }

        imageLoader = coordinator.resolver.resolve()
        imageFavouritesService = coordinator.resolver.resolve()
    }

    var initalLoaded = false
    func onAppear() async {
        logger.info("Gallery appear")

        if !initalLoaded {
            initalLoaded = true
            try? await loadData()
        } else {
            await readFavorites()
        }
    }

    func viewDetails(_ photo: PexelsPhoto) {
        coordinator.present(sheet: .detail(photo: photo))
    }

    @MainActor
    private func loadData() async throws {
        logger.info("Starting data load")
        isLoading = true
        defer { isLoading = false }

        switch mode {
        case let .search(query):
            logger.info("Performing search: \(query, privacy: .private)")
            photos = try await imageLoader.search(query: query)
        case .curated:
            logger.info("Loading curated")
            photos = try await imageLoader.curated()
        case .saved:
            await readFavorites()
        }
        selectedPhoto = photos.first
    }

    @MainActor
    private func readFavorites() async {
        guard mode == .saved else { return }
        photos = await imageFavouritesService.savedImages()

        if let selectedPhoto = selectedPhoto,
           photos.contains(selectedPhoto) == false {
            // Reset the selected photo if its no longer favorited
            self.selectedPhoto = photos.first
        }
    }

    func isFavorite(_ image: PexelsPhoto) -> Bool {
        imageFavouritesService.contains(imageId: image.id)
    }

    func toggleFavorite() {
        guard let selectedPhoto = selectedPhoto
        else { return }

        if isFavorite(selectedPhoto) {
            imageFavouritesService.remove(selectedPhoto.id)
        } else {
            imageFavouritesService.save(selectedPhoto)
        }
        objectWillChange.send()
    }
}
