//
//  MessageBank.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

struct MessageBank {
    let messages: [Message] = [
        .init(text: "Apples are red",
              symbol: "apple.logo",
              tint: .red),
        .init(text: "Carrots make you strong",
              symbol: "carrot.fill",
              tint: .orange),
        .init(text: "The sun is bright",
              symbol: "sun.haze.fill",
              tint: .yellow),
        .init(text: "Leafs can fly in the wind",
              symbol: "leaf.fill",
              tint: .green),
        .init(text: "Water is refreshing",
              symbol: "drop.fill",
              tint: .blue),
        .init(text: "The moon is soothing",
              symbol: "moon.fill",
              tint: .indigo),
        .init(text: "Lightning is scary",
              symbol: "bolt.fill",
              tint: .purple)
    ]
}
