//
//  SFSymbolTests.swift
//  ImagesAppTests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Testing
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
@testable import ImagesApp

struct SFSymbolTests {

    @Test(arguments: SFSymbol.allCases)
    func check(symbol: SFSymbol) async throws {
#if canImport(UIKit)
    let name = symbol.rawValue
    let image = UIImage(systemName: name)
    #expect(image != nil, "Invalid SF Symbol: \(name)")
#elseif canImport(AppKit)
    let name = symbol.rawValue
    let image = NSImage(systemSymbolName: name, accessibilityDescription: nil)
    #expect(image != nil, "Invalid SF Symbol: \(name)")
#else
    // Platform without SF Symbols — treat as a no-op so CI on other platforms doesn't fail.
    #expect(true)
#endif
    }

}
