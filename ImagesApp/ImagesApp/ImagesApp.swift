//
//  ImagesApp.swift
//  ImagesApp
//
//  Created by Sushant Verma on 7/8/2025.
//

import SwiftUI

@main
struct ImagesApp: App {
    @StateObject private var resolver = DependencyResolver.forApp() // ⬅️ Persist for app lifecycle

    var body: some Scene {
        WindowGroup {
            TabContainerView(di: resolver)
        }
    }
}
