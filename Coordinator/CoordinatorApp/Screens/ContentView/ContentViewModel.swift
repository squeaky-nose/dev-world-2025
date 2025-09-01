//
//  ContentViewModel.swift
//  BasicApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

final class ContentViewModel: ObservableObject {

    let logger = AutoLogger.unifiedLogger()

    private let coordinator: Coordinator

    @Published var icon = SFSymbol.globe
    @Published var text = "Hello, World!"

    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
        logger.info("Created")
    }

    func performAction() {
        logger.info("Button tapped")

        logger.info("Navigating to next screen")
        coordinator.push(.placeholder)
        //coordinator.present(sheet: .placeholder)
        //coordinator.present(fullScreen: .placeholder)

        logger.warning("Updating content")
        icon = .faceDashed
        text = "Welcome back!"

    }
}
