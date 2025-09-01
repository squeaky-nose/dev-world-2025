//
//  CuratedGalleryViewModelTests.swift
//  ImagesAppTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp
import Testing

struct CuratedGalleryViewModelTests {

    let testMode = GalleryViewModel.Mode.curated

    let dependencyResolver: DependencyResolver
    let coordinator: Coordinator
    let viewModel: GalleryViewModel

    let inMemoryImageStore: InMemoryImageFavourites
    let mockImageLoader: MockSimpleImageLoader

    init() {
        self.dependencyResolver = DependencyResolver.createEmpty()

        let inMemoryImageStore = InMemoryImageFavourites()
        self.inMemoryImageStore = inMemoryImageStore
        dependencyResolver.register(ImageFavouritesService.self, resolved: .perResolution) { _ in
            inMemoryImageStore
        }

        let mockImageLoader = MockSimpleImageLoader()
        self.mockImageLoader = mockImageLoader
        dependencyResolver.register(ImageLoader.self, resolved: .perResolution) { _ in
            mockImageLoader
        }

        self.coordinator = Coordinator(inParent: nil, di: dependencyResolver)
        self.viewModel = .init(coordinator, mode: testMode)
    }

    @Test func testTitle() async throws {
        #expect(viewModel.pageTitle == "Curated Images")
    }

    @Test func noImagesText() async throws {
        #expect(viewModel.noImagesText == "gallery.results.none")
        #expect(viewModel.noImagesText.string == "No images")
    }

    @Test func loadingText() async throws {
        #expect(viewModel.loadingText == "galary.loading.text")
        #expect(viewModel.loadingText.string == "Loading")
    }

    @Test func noImagesSystemImage() async throws {
        #expect(viewModel.noImagesSystemImage == .cameraMacroSlash)
    }

    @Test func defaultPhotos() async throws {
        #expect(viewModel.photos.isEmpty)
    }

    @Test func noSelectedPhoto() async throws {
        #expect(viewModel.selectedPhoto == nil)
    }

    @Test func displayPhotos() async throws {
        await viewModel.onAppear()

        #expect(viewModel.photos == mockImageLoader.curatedResults)
        #expect(viewModel.selectedPhoto == mockImageLoader.curatedResults.first)
        #expect(viewModel.selectedPhoto != nil)
    }
}
