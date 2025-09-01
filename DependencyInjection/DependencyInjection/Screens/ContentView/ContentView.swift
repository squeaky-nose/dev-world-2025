//
//  ContentView.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct ContentView: View {
    var resolver: DependencyResolver
    
    @StateObject var viewModel: ContentViewModel
    
    init(_ resolver: DependencyResolver) {
        self.resolver = resolver
        _viewModel = .init(wrappedValue: .init(resolver))
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                viewModel.updateMessage()
            }
        }, label: {
            VStack {
                Image(systemName: viewModel.message.symbol)
                    .accessibilityIdentifier("image-icon")
                    .imageScale(.large)
                Text(viewModel.message.text)
                    .accessibilityIdentifier("text-label")
            }
            .foregroundStyle(viewModel.message.tint)
            .scaleEffect(1.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
        .accessibilityIdentifier("action-button")
        .background(viewModel.message.tint.opacity(0.2))
    }
}

#Preview {
    NavigationStack {
        ContentView(.forPreview())
    }
}
