//
//  StandardNavRoute.swift
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

enum StandardNavRoute: Hashable, Identifiable {
    var id: String { String(describing: self) }

    case welcome
    case placeholder
}
