//
//  CoordindatorContent.swift
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


import SwiftUI

// MARK: - Root View
struct CoordindatorContent: View {
    @StateObject private var coordinator: Coordinator
    @StateObject private var resolver: DependencyResolver

    var rootRoute: StandardNavRoute

    init(_ rootRoute: StandardNavRoute,
         di resolver: DependencyResolver,
         within parentCoordinator: Coordinator? = nil) {
        let coordinator = Coordinator(inParent: parentCoordinator, di: resolver)
        self._coordinator = .init(wrappedValue: coordinator)
        self._resolver = .init(wrappedValue: resolver)
        self.rootRoute = rootRoute
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(for: rootRoute)
                .navigationDestination(for: StandardNavRoute.self) { route in
                    coordinator.buildView(for: route)
                }
        }
        .sheet(item: $coordinator._sheetRoute) { route in
            coordinator.buildModal(for: route)
        }
        .fullScreenCover(item: $coordinator._fullScreenCoverRoute) { route in
            coordinator.buildModal(for: route)
        }
    }
}
// MARK: - Preview
#Preview {
    CoordindatorContent(.placeholder, di: .forPreview())
}
