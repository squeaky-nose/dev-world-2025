//
//  AutoLogger.swift
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import OSLog

class AutoLogger {
    /**
     Helper for building a OSLog logger.
     */
    static func unifiedLogger(category: String = #function) -> os.Logger {
        os.Logger(subsystem: Bundle.main.bundleIdentifier!,
                  category: category)
    }

    // Suggestion: Can add https://github.com/apple/swift-log here
}
