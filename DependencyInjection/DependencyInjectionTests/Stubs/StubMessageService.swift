//
//  StubMessageService.swift
//  ExternalLibrary
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

@testable import DependencyInjection

class StubMessageService: MessageService {
    var nextMessage: Message
    var callCount = 0
    
    init(nextMessage: Message) {
        self.nextMessage = nextMessage
    }
    
    func getMessage() -> Message {
        callCount += 1
        return nextMessage
    }
}
