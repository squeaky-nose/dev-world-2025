//
//  ContentView.swift
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel

    var body: some View {
        VStack {
            Button(action: viewModel.performAction) {
                VStack {
                    Image(systemName: viewModel.icon())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .foregroundStyle(.tint)
                    Text(viewModel.text)
                        .font(.title)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CoordindatorContent(.welcome)
}
