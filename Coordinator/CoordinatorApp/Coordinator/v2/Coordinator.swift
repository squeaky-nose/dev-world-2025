//
//  Coordinator.swift
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

    init(inParent parent: Coordinator?) {
        logger.info("CREATING COORDINATOR")

        self.parent = parent
    }

    deinit {
        logger.info("DESTROYING COORDINATOR")
    }

    // Navigation Stack Methods
    func push(_ route: StandardNavRoute) { path.append(route) }
    func pop() { if !path.isEmpty { path.removeLast() } }
    func popToRoot() { path.removeLast(path.count) }

    // Modal Methods
    func present(sheet route: StandardNavRoute) { self._sheetRoute = route }
    func present(fullScreen route: StandardNavRoute) { self._fullScreenCoverRoute = route }

    func dismissModal() {
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
        self._sheetRoute = nil
        self._fullScreenCoverRoute = nil
    }

    // Build Navigation Views
    @ViewBuilder
    func buildView(for route: StandardNavRoute) -> some View {
        switch route {
        case .welcome:
            ContentView(viewModel: .init(self))
        case .placeholder:
            PlaceholderView()
        }
    }

    @ViewBuilder
    func buildModal(for route: StandardNavRoute) -> some View {
        CoordindatorContent(route,
                    within: self)
    }
}
