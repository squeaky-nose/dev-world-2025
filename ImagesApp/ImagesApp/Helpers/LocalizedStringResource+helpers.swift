//
//  LocalizedStringResource+helpers.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

extension LocalizedStringResource {
    var text: Text { Text(self) }
    var string: String { String(localized: self) }
}
