//
//  NewImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI
import LeapML

struct NewImage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    let listViewModel: InferenceList.ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Prompt", text: self.$viewModel.prompt)
                TextField("Negative prompt", text: self.$viewModel.negativePrompt)
                VStack {
                    HStack {
                        Text("Size:")
                        Spacer()
                        Text(self.viewModel.resolution.sizeString)
                    }
                    ResolutionPicker(selection: self.$viewModel.resolution)
                }
                Stepper("Steps: \(self.viewModel.steps)", onIncrement: {
                    self.viewModel.steps = min(50, self.viewModel.steps + 1)
                }, onDecrement: {
                    self.viewModel.steps = max(1, self.viewModel.steps - 1)
                })
                Stepper("Prompt strength: \(self.viewModel.promptStrength)", onIncrement: {
                    self.viewModel.promptStrength = min(30, self.viewModel.promptStrength + 1)
                }, onDecrement: {
                    self.viewModel.promptStrength = max(0, self.viewModel.promptStrength - 1)
                })
                Stepper("Number of images: \(self.viewModel.numberOfImages)", onIncrement: {
                    self.viewModel.numberOfImages = min(20, self.viewModel.numberOfImages + 1)
                }, onDecrement: {
                    self.viewModel.numberOfImages = max(1, self.viewModel.numberOfImages - 1)
                })
            }
            .toolbar {
                Button("Submit", action: self.buttonAction)
                    .disabled(!self.viewModel.isValid)
                    .accessibilityHint(
                        self.viewModel.isValid
                        ? "Submit parameters to create a new image"
                        : "Fill in all parameters before you can submit"
                    )
            }
            .navigationTitle("New image")
        }
    }
    
    private func buttonAction() {
        self.dismiss()
        let requestBody = GenerateImageService.RequestBody(
            prompt: self.viewModel.prompt,
            negativePrompt: self.viewModel.negativePrompt,
            steps: self.viewModel.steps,
            width: self.viewModel.resolution.width,
            height: self.viewModel.resolution.height,
            numberOfImages: self.viewModel.numberOfImages,
            promptStrength: self.viewModel.promptStrength
        )
        GenerateImageTask.run(requestBody: requestBody, listViewModel: self.listViewModel)
    }
}

struct NewImage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Color.white
                .navigationTitle("Preview")
                .popover(isPresented: .constant(true)) {
                    NewImage(listViewModel: InferenceList.ViewModel.mock)
                }
        }
    }
}
