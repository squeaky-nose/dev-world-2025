//
//  DependencyResolver+App.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

extension DependencyResolver {
    /// For the app
    static func forApp() -> DependencyResolver {
        let resolver = DependencyResolver.createEmpty()
        resolver.register(MessageBank.self, resolved: .perResolution) { _ in
            MessageBank()
        }
        
        resolver.register(MessageService.self, resolved: .weak) { _ in
            return SequencedMessageService(resolver)
        }
        return resolver
    }
}
