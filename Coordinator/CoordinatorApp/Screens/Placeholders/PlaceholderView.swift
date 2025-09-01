//
//  PlaceholderView.swift
//  CoordinatorApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct PlaceholderView: View {
    let logger = AutoLogger.unifiedLogger()

    var body: some View {
        VStack {
            Image(systemName: "waveform")
                .foregroundStyle(.green)
            Spacer().frame(height: 26)
            HStack {
                Image(systemName: "ear.fill")
                    .scaleEffect(x: -1, y: 1)
                    .foregroundStyle(.gray)
                Spacer().frame(width: 5)

                Image(systemName: "eye")
                Image(systemName: "eye.fill")
                    .foregroundStyle(.red)

                Spacer().frame(width: 5)
                Image(systemName: "ear")
            }
            Image(systemName: "nose")
            Spacer().frame(height: 6)
            Image(systemName: "mouth")
                .foregroundStyle(.pink)
        }
        .overlay(
            Ellipse()
                .stroke(Color.black, lineWidth: 4)
                .frame(width: 75, height: 120)
        )
        .onAppear {
            logger.info(".onAppear()")
        }

        Spacer().frame(height: 16)

        Text("**Hello**, World!")
    }
}

#Preview {
    PlaceholderView()
}
