//
//  SearchViewModelTests.swift
//  ImagesAppTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import ImagesApp
import Testing

struct SearchViewModelTests {

    struct DisplayState: Equatable {
        let searchText: String
        let shouldShowCurated: Bool
        let shouldShowSearch: Bool
        let shouldShowLuckyResult: Bool
        let showingAlert: Bool
    }

    let dependencyResolver: DependencyResolver
    let coordinator: Coordinator
    let viewModel: SearchViewModel

    let mockImageLoader: MockSuspendedImageLoader

    init() {
        self.dependencyResolver = DependencyResolver.createEmpty()

        let mockImageLoader = MockSuspendedImageLoader()
        self.mockImageLoader = mockImageLoader
        dependencyResolver.register(ImageLoader.self, resolved: .perResolution) { _ in
            mockImageLoader
        }

        self.coordinator = Coordinator(inParent: nil, di: dependencyResolver)
        self.viewModel = .init(coordinator)
    }

    @Test func title() async throws {
        #expect(viewModel.title == "search.title")
        #expect(viewModel.title.string == "Search")
    }

    @Test func searchPlaceholder() async throws {
        #expect(viewModel.searchPlaceholder == "search.searchField.placeholder")
        #expect(viewModel.searchPlaceholder.string == "Enter your search…")
    }

    @Test func curatedButtonText() async throws {
        #expect(viewModel.curatedButtonText == "search.viewCurated.button")
        #expect(viewModel.curatedButtonText.string == "Curated")
    }

    @Test func searchButtonText() async throws {
        #expect(viewModel.searchButtonText == "search.performSearch.button")
        #expect(viewModel.searchButtonText.string == "Perform search")
    }

    @Test func luckyButtonText() async throws {
        #expect(viewModel.luckyButtonText == "search.luckyResult.button")
        #expect(viewModel.luckyButtonText.string == "Im feeling lucky")
    }

    @Test func defaultState() async throws {
        #expect(viewModel.currentState == .init(
            searchText: "",
            shouldShowCurated: true,
            shouldShowSearch: false,
            shouldShowLuckyResult: false,
            showingAlert: false
        ))
        #expect(coordinator.path.isEmpty)
        #expect(mockImageLoader.totalCalls == 0)
    }

    @Test func enteringSearch() async throws {
        viewModel.searchText = "unit test"
        #expect(viewModel.currentState == .init(
            searchText: "unit test",
            shouldShowCurated: false,
            shouldShowSearch: true,
            shouldShowLuckyResult: true,
            showingAlert: false
        ))
        #expect(mockImageLoader.totalCalls == 0)
    }

    @Test func viewingCurated() async throws {
        viewModel.showCurated()

        #expect(coordinator.path == [.curated])
        #expect(mockImageLoader.totalCalls == 0) // this screen doesnt perform search
    }

    @Test func perfomSearch() async throws {
        viewModel.searchText = "unit test"
        viewModel.perfomSearch()

        #expect(coordinator.path == [.results(searchPhrase: "unit test")])
        #expect(mockImageLoader.totalCalls == 0) // this screen doesnt perform search
    }

    @Test func perfomSearchWithNoTextDoesNothing() async throws {
        viewModel.perfomSearch()

        #expect(coordinator.path.isEmpty)
    }

    @Test func showBestMatch() async throws {
        guard let expectedMatch = mockImageLoader.searchResults.first
        else {
            Issue.record("No search result")
            return
        }

        viewModel.searchText = "best match"
        let task = Task {
            await viewModel.showBestMatchAsync()
        }

        await Task.yield() // Yield to let other tasks run
        await MainActor.run { () in } // Ensure MainActor processes its queue
        await MainActor.run { () in } // not sure why we need to do this multiple times :(

        #expect(viewModel.currentState == .init(
            searchText: "best match",
            shouldShowCurated: false,
            shouldShowSearch: true,
            shouldShowLuckyResult: true,
            showingAlert: true
        ))
        #expect(viewModel.alertContent?.title == "Searching")
        #expect(viewModel.alertContent?.actions.count == 1)

        switch viewModel.alertContent?.actions.first {
        case let .cancel(text, _):
            #expect(text == "Cancel")
        default:
            #expect(Bool(false), "Unexpected alert action")
        }
        #expect(coordinator.path == []) // has not navigated yet
        #expect(coordinator._sheetRoute == nil) // is not showing sheet

        mockImageLoader.resume()
        await task.value
        #expect(viewModel.alertContent == nil) // alert has disappeared
        #expect(coordinator.path == []) // has still not navigated
        #expect(coordinator._sheetRoute == .detail(photo: expectedMatch)) // is now showing sheet

        #expect(mockImageLoader.totalCalls == 1)
    }
}

private extension SearchViewModel {
    var currentState: SearchViewModelTests.DisplayState {
        .init(searchText: searchText,
              shouldShowCurated: shouldShowCurated,
              shouldShowSearch: shouldShowSearch,
              shouldShowLuckyResult: shouldShowLuckyResult,
              showingAlert: alertContent != nil)
    }
}
