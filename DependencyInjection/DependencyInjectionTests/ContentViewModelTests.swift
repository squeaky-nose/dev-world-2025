//
//  ContentViewModelTests.swift
//  DependencyInjectionTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Testing
@testable import DependencyInjection

@Suite // ❤️ Runs in parallel
struct ContentViewModelTests {

    var stubMessageService: StubMessageService
    var viewModel: ContentViewModel
    
    init() async throws {
        let resolver = DependencyResolver.createEmpty() // ⬅️ Each @Test has its own resolver 😍

        let stubMessageService = StubMessageService(nextMessage: .init(text: "initial stub message",
                                                                       symbol: "globe",
                                                                       tint: .red))

        resolver.register(MessageService.self, resolved: .weak) { _ in stubMessageService }
        self.stubMessageService = stubMessageService

        self.viewModel = .init(resolver)
    }
    
    @Test func initialMessage() async throws {
        #expect(viewModel.message.text == "initial stub message")
        #expect(viewModel.message.symbol == "globe")
        #expect(viewModel.message.tint == .red)
        #expect(stubMessageService.callCount == 1)
    }

    @Test func nextMessage() async throws {
        stubMessageService.nextMessage = .init(text: "test case message",
                                               symbol: "circle",
                                               tint: .orange)

        viewModel.updateMessage()
        
        #expect(viewModel.message.text == "test case message")
        #expect(viewModel.message.symbol == "circle")
        #expect(viewModel.message.tint == .orange)
        #expect(stubMessageService.callCount == 2)
    }

}
