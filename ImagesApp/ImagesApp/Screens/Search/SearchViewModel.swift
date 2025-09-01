//
//  SearchViewModel.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

final class SearchViewModel: ObservableObject {

    var coordinator: Coordinator

    let logger = AutoLogger.unifiedLogger()

    @Published var title: LocalizedStringResource = "search.title"
    @Published var searchPlaceholder: LocalizedStringResource = "search.searchField.placeholder"

    @Published var curatedButtonText: LocalizedStringResource = "search.viewCurated.button"
    @Published var searchButtonText: LocalizedStringResource = "search.performSearch.button"
    @Published var luckyButtonText: LocalizedStringResource = "search.luckyResult.button"

    @Published var luckySearchAlertTitle: LocalizedStringResource = "search.luckyAlert.title"
    @Published var luckySearchAlertCancelButton: LocalizedStringResource = "search.luckyAlert.cancel.button"

    @Published var searchText: String = ""
    @Published var alertContent: AlertContent?

    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    var shouldShowCurated: Bool {
        searchText.isEmpty
    }

    var shouldShowSearch: Bool {
        !searchText.isEmpty
    }

    var shouldShowLuckyResult: Bool {
        !searchText.isEmpty
    }

    func perfomSearch() {
        guard shouldShowSearch else {
            return logger.error("missing search value")
        }

        logger.info("Performing search with \(self.searchText, privacy: .private)")

        coordinator.push(.results(searchPhrase: searchText))
    }

    func showCurated() {
        if !shouldShowCurated {
            logger.warning("How did user perform action?")
        }

        logger.info("Showing curated")

        coordinator.push(.curated)
    }

    func showBestMatch() {
        Task {
            await showBestMatchAsync()
        }
    }

    @MainActor
    func showBestMatchAsync() async {
        let imageLoader: ImageLoader = coordinator.resolver.resolve()

        var abort = false
        alertContent = .init(title: luckySearchAlertTitle.string,
                             actions: [.cancel(label: luckySearchAlertCancelButton.string,
                                               callback: { abort = true })])
        let matches = try? await imageLoader.search(query: searchText)
        alertContent = nil

        if let firstMatch = matches?.first, !abort {
            coordinator.present(sheet: .detail(photo: firstMatch))
        } else {
            logger.error("No best match found")
        }
    }
}
