//
//  ProcessInfo+Preview.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 24/02/2023.
//

import Foundation

extension ProcessInfo {
    static var isPreview: Bool {
        Self.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
