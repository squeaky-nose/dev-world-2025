//
//  DependencyResolver+UiTests.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025.
//

#if DEBUG
extension DependencyResolver {
    /// For UI Tests
    static func forUITests() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        resolver.register(MessageService.self, resolved: .singleton) { _ in
            SortedMessageService(resolver)
        }
        return resolver
    }
}
#endif
