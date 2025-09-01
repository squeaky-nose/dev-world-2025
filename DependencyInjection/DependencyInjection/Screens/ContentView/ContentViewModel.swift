//
//  ContentViewModel.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation
import SwiftUICore

class ContentViewModel: ObservableObject {
    
    @Published var message: Message
    
    var messageService: MessageService
    
    init(_ resolver: DependencyResolver) {
        self.messageService = resolver.resolve(MessageService.self)
        self.message = messageService.getMessage()
    }
    
    func updateMessage() {
        message = messageService.getMessage()
    }
}
