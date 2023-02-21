//
//  String_Utils.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/02/2023.
//

import Foundation

extension String {
    var dashIfEmpty: String {
        self.isEmpty ? "—" : self
    }
}
