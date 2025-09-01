//
//  RandomMessageService.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

class RandomMessageService: MessageService {
    
    var messages: [Message]
    
    init(_ resolver: DependencyResolver) {
        let messageBank = resolver.resolve(MessageBank.self)
        self.messages = messageBank.messages
    }
    
    func getMessage() -> Message {
        return messages.randomElement()!
    }
}
