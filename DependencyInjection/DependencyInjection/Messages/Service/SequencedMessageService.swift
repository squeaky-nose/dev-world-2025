//
//  SequencedMessageService.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

class SequencedMessageService: MessageService {
    
    var messages: [Message]
    var currentIndex = 0
    
    init(_ resolver: DependencyResolver) {
        let messageBank = resolver.resolve(MessageBank.self)
        self.messages = messageBank.messages
    }
    
    func getMessage() -> Message {
        defer {
            currentIndex = (currentIndex+1) % messages.count
        }
        return messages[currentIndex]
    }
}
