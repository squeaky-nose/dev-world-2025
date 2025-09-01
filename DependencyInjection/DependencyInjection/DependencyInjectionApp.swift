//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

@main
struct DependencyInjectionApp: App {
    @StateObject private var resolver: DependencyResolver  // ⬅️ Persist for app lifecycle

    init() {
        let isRunningXcodePreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        let isRunningUITest = ProcessInfo.processInfo.environment["RUNNING_FOR_UI_TEST"] == "1"
        let resolver: DependencyResolver
        if isRunningXcodePreviews {
            resolver = DependencyResolver.forPreview()
        } else if isRunningUITest {
            resolver = DependencyResolver.forUITests()
        } else {
            resolver = DependencyResolver.forApp()
        }

        _resolver = .init(wrappedValue: resolver)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(resolver)
            }
        }
    }
}
