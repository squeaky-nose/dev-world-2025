//
//  SavedGalleryViewModelTests.swift
//  ImagesAppTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp
import Testing

struct SavedGalleryViewModelTests {

    let testMode = GalleryViewModel.Mode.saved

    let dependencyResolver: DependencyResolver
    let coordinator: Coordinator
    let viewModel: GalleryViewModel

    let inMemoryImageStore: InMemoryImageFavourites
    let mockImageLoader: MockSuspendedImageLoader

    let testPhoto = PexelsPhoto(id: 42,
                                width: 4,
                                height: 2,
                                alt: "unit test saved",
                                photographer: "/dev/world 2025",
                                src: .init(
                                    original: "http://localhost/original.png",
                                    large: "http://localhost/large.png",
                                    medium: "http://localhost/medium.png",
                                    small: "http://localhost/small.png"))

    init() {
        self.dependencyResolver = DependencyResolver.createEmpty()

        let inMemoryImageStore = InMemoryImageFavourites()
        self.inMemoryImageStore = inMemoryImageStore
        dependencyResolver.register(ImageFavouritesService.self, resolved: .perResolution) { _ in
            inMemoryImageStore
        }

        let mockImageLoader = MockSuspendedImageLoader()
        self.mockImageLoader = mockImageLoader
        dependencyResolver.register(ImageLoader.self, resolved: .perResolution) { _ in
            mockImageLoader
        }

        self.coordinator = Coordinator(inParent: nil, di: dependencyResolver)
        self.viewModel = .init(coordinator, mode: testMode)
    }

    @Test func testTitle() async throws {
        #expect(viewModel.pageTitle == "Saved Images")
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
        inMemoryImageStore.save(testPhoto)
        await viewModel.onAppear()
        #expect(viewModel.photos.count == 1)
        #expect(viewModel.photos == [testPhoto])
        #expect(viewModel.selectedPhoto == testPhoto)
    }

    @Test func toggleFavoriteDoesntUpdateImmediately() async throws {
        inMemoryImageStore.save(testPhoto)
        #expect(inMemoryImageStore.images.count == 1)
        await viewModel.onAppear()

        #expect(inMemoryImageStore.images == [testPhoto])
        #expect(viewModel.photos == [testPhoto])

        viewModel.toggleFavorite()
        #expect(viewModel.photos.count == 1) // not yet updated
        #expect(viewModel.selectedPhoto == testPhoto)

        await viewModel.onAppear()
        #expect(viewModel.photos.isEmpty)//now updated
        #expect(viewModel.selectedPhoto == nil)
    }
}
