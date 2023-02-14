//
//  DisplayableError.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 14/02/2023.
//

import Foundation

struct DisplayableError: Error, LocalizedError {
    let errorDescription: String?

    init(_ description: String) {
        errorDescription = description
    }
}
