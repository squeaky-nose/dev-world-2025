//
//  Coordinator.swift
//  BasicApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: [StandardNavRoute] = []

    /// Do not assign directly from outside. Use presentModal(..) instead
    @Published var _sheetRoute: StandardNavRoute? = nil

    /// Do not assign directly from outside. Use presentSheet(...) instead
    @Published var _fullScreenCoverRoute: StandardNavRoute? = nil

    private let logger = AutoLogger.unifiedLogger()

    weak var parent: Coordinator?
    let resolver: DependencyResolver

    init(inParent parent: Coordinator?,
         di resolver: DependencyResolver) {
        logger.info("CREATING COORDINATOR")

        self.parent = parent
        self.resolver = resolver
    }

    deinit {
        logger.info("DESTROYING COORDINATOR")
    }

    // Navigation Stack Methods
    func push(_ route: StandardNavRoute) {
        logger.info("Pushing new route: \(route.id)")
        path.append(route)
    }
    func pop() {
        if !path.isEmpty {
            let removed = path.removeLast()
            logger.info("Removed route: \(removed.id)")
        } else {
            logger.warning("Unable to pop - path is empty")
        }
    }
    func popToRoot() {
        let countToRemove = path.count
        logger.info("Removing \(countToRemove) routes")
        path.removeLast(countToRemove)
    }

    // Modal Methods
    func present(sheet route: StandardNavRoute) {
        logger.info("Presenting route as sheet: \(route.id)")
        self._sheetRoute = route
    }
    func present(fullScreen route: StandardNavRoute) {
        logger.info("Presenting route as fullscreen: \(route.id)")
        self._fullScreenCoverRoute = route
    }

    func dismissModal() {
        logger.info("Dismissing child modal")
        guard let parent = parent
        else {
            return logger.warning("Coordinator should have a parent when dismissing modal")
        }

        guard parent._sheetRoute != nil || parent._fullScreenCoverRoute != nil
        else {
            return logger.warning("Parent coordinator should be presenting content")
        }

        parent._sheetRoute = nil
        parent._fullScreenCoverRoute = nil
    }

    func dismissPresentedContent() {
        logger.info("Dismissing presented child content")
        self._sheetRoute = nil
        self._fullScreenCoverRoute = nil
    }

    // Build Navigation Views
    @ViewBuilder
    func buildView(for route: StandardNavRoute) -> some View {
        switch route {
        case .search:
            SearchView(viewModel: .init(self))
        case let .results(searchPhrase):
            GalleryView(viewModel: .init(self, mode: .search(searchPhrase)))
        case .curated:
            GalleryView(viewModel: .init(self, mode: .curated))
        case .saved:
            GalleryView(viewModel: .init(self, mode: .saved))
        case let .detail(image):
            AnalysisView(viewModel: .init(self, image: image))
        case .placeholder:
            PlaceholderView()
        }
    }

    @ViewBuilder
    func buildModal(for route: StandardNavRoute) -> some View {
        CoordindatorContent(route,
                            di: resolver,
                            within: self)
    }
}
