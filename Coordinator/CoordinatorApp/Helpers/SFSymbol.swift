//
//  SFSymbol.swift
//  BasicApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

enum SFSymbol: String {
    case globe
    case faceDashed = "face.dashed"

    func callAsFunction() -> String { rawValue }
}
