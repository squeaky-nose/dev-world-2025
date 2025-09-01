//
//  CoordindatorContent.swift
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//


import SwiftUI

// MARK: - Root View
struct CoordindatorContent: View {
    @StateObject private var coordinator: Coordinator

    var rootRoute: StandardNavRoute

    init(_ rootRoute: StandardNavRoute,
         within parentCoordinator: Coordinator? = nil) {
        let coordinator = Coordinator(inParent: parentCoordinator)
        self._coordinator = StateObject(wrappedValue: coordinator)
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
    CoordindatorContent(.welcome)
}
