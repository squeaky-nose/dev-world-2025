//
//  SFSymbol.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

enum SFSymbol: String, CaseIterable {
    case globe
    case faceDashed = "face.dashed"
    case cameraMacroSlash = "camera.macro.slash"
    case houseFill = "house.fill"
    case document
    case heart
    case heartFill = "heart.fill"
    case xmark

    func callAsFunction() -> String { rawValue }
}
