//
//  NewImage+ViewModel.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 16/02/2023.
//

import Foundation

extension NewImage {
    struct ViewModel {
        var prompt = ""
        var negativePrompt = ""
        var steps = 50
        var promptStrength = 7
        
        var isValid: Bool {
            !prompt.isEmpty
        }
    }
}
