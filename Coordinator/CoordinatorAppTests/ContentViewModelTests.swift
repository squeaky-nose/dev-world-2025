//
//  ContentViewModelTests.swift
//  BasicAppTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Testing
@testable import Coordinator

struct ContentViewModelTests {

    let coordinator: Coordinator
    let viewModel: ContentViewModel

    init() {
        self.coordinator = Coordinator(inParent: nil)
        self.viewModel = .init(coordinator)
    }

    @Test func defaultIcon() async throws {
        #expect(viewModel.icon == .globe)
    }

    @Test func defaultText() async throws {
        #expect(viewModel.text == "Hello, World!")
    }

    @Test
    func performAction() async throws {
        // Make sure we're on the first screen...
        #expect(coordinator.path.count == 0)

        viewModel.performAction()

        // Check that we've navigated forward
        #expect(coordinator.path.count == 1)
        #expect(coordinator.path.last == .placeholder)
        #expect(coordinator.path == [.placeholder])

        // and that we've updated outselves
        #expect(viewModel.icon == .faceDashed)
        #expect(viewModel.text == "Welcome back!")
    }
}
