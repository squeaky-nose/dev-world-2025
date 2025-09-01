//
//  TabContainerView.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct TabContainerView: View {
    enum Tab {
        case search
        case saved
        case settings
    }

    @State private var selectedTab: Tab
    @StateObject private var resolver: DependencyResolver

    init(selectedTab: Tab = .search,
         di resolver: DependencyResolver) {
        self.selectedTab = selectedTab
        self._resolver = .init(wrappedValue: resolver)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            CoordindatorContent(.search, di: resolver)
                .tabItem{ Label("tab.search.label", systemImage: SFSymbol.houseFill()) }
                .tag(Tab.search)

            CoordindatorContent(.saved, di: resolver)
                .tabItem{ Label("tab.saved.label", systemImage: SFSymbol.heartFill()) }
                .tag(Tab.saved)
        }
    }
}
