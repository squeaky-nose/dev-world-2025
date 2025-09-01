//
//  ContentView.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                TextField(text: $viewModel.searchText) {
                    Text(viewModel.searchPlaceholder)
                }
            }
            .frame(height: 44)
            .padding()

            Divider().frame(height: 1)
            VStack {
                if viewModel.shouldShowCurated {
                    Button(action: viewModel.showCurated) {
                        Text(viewModel.curatedButtonText)
                    }
                    .buttonStyle(.bordered)
                }
                if viewModel.shouldShowSearch {
                    Button(action: viewModel.perfomSearch) {
                        Text(viewModel.searchButtonText)
                    }
                    .buttonStyle(.borderedProminent)
                }
                if viewModel.shouldShowLuckyResult {
                    Button(action: viewModel.showBestMatch ) {
                        Text(viewModel.luckyButtonText)
                    }
                    .buttonStyle(.bordered)
                }
            }

            Spacer().frame(maxHeight: .infinity)
        }
        .navigationTitle(Text(viewModel.title))
        .modifier(AlertModifier(alert: $viewModel.alertContent))
    }
}

#Preview {
    TabContainerView(selectedTab: .search, di: .forPreview())
}
