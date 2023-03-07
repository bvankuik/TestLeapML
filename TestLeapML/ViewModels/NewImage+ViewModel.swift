//
//  NewImage+ViewModel.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 16/02/2023.
//

import Foundation
import LeapML

extension NewImage {
    struct ViewModel {
        var prompt = ""
        var negativePrompt = ""
        var resolution = ResolutionPicker.resolutions[0]
        var steps = 50
        var promptStrength = 7
        var numberOfImages = 1
        
        var isValid: Bool {
            !prompt.isEmpty
        }
    }
}
