//
//  NewImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import OSLog
import SwiftUI

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

struct NewImage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    let listViewModel: InferenceList.ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Prompt", text: self.$viewModel.prompt)
                TextField("Negative prompt", text: self.$viewModel.negativePrompt)
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
            }
            .toolbar {
                Button("Submit", action: self.buttonAction)
                    .disabled(!self.viewModel.isValid)
            }
            .navigationTitle("New image")
        }
    }
    
    private func buttonAction() {
        self.dismiss()
        Task {
            let requestBody = GenerateImageService.RequestBody(newImageViewModel: self.viewModel)
            do {
                let newJob = try await GenerateImageService.call(requestBody: requestBody)
                if let index = await self.listViewModel.jobs.firstIndex(where: { $0.id == newJob.id }) {
                    // do nothing
                    os_log("At index %d, already found new inference with ID = %@", log: .default, type: .info, index, newJob.id)
                } else {
                    os_log("Refreshing to get new inference with ID = %@", log: .default, type: .info, newJob.id)
                    await self.listViewModel.refresh()
                }
            } catch {
                os_log("%@", log: .default, type: .info, error.localizedDescription)
                throw DisplayableError("Error calling GenerateImageService:\n\(error.localizedDescription)")
            }
        }
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
