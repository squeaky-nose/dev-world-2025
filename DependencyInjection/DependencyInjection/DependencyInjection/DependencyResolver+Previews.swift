//
//  DependencyResolver+Previews.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

#if DEBUG
extension DependencyResolver {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        resolver.register(MessageService.self, resolved: .singleton) { _ in
            PreviewMessageService()
        }
        return resolver
    }
}
#endif
