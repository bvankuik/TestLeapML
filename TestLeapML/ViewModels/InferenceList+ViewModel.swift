//
//  InferenceListViewModel.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 15/02/2023.
//

import SwiftUI
import OSLog
import LeapML

extension InferenceList {
    @MainActor class ViewModel: ObservableObject {
        @Published var jobs: [InferenceJob] = []
        
        func refresh() async throws {
            do {
                let jobs = try await ListInferenceService.call()
                self.jobs = jobs.sortedNewestFirst()
            } catch {
                os_log("%@", log: .default, type: .info, error.localizedDescription)
                throw DisplayableError("Error calling list inferences:\n\(error.localizedDescription)")
            }
        }
        
        static var mock: ViewModel {
            let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")
            let viewModel = ViewModel()
            viewModel.jobs = jobs.sortedNewestFirst()
            return viewModel
        }
    }
}
