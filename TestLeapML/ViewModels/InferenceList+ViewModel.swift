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
    @MainActor class ViewModel: ObservableObject, HasRequestStatus {
        @Published var jobs: [InferenceJob] = []
        @Published var requestStatus = RequestStatus.idle
        
        @discardableResult
        func refresh() async throws -> Int {
            do {
                self.requestStatus = .loading
                let jobs = try await ListInferenceService.call()
                self.requestStatus = .success
                self.jobs = jobs.sortedNewestFirst()
                let queuedCount = jobs.filter { $0.status == .queued }.count
                return queuedCount
            } catch {
                os_log("%@", log: .default, type: .info, error.localizedDescription)
                let displayableError = DisplayableError("Error calling list inferences:\n\(error.localizedDescription)")
                self.requestStatus = .error(displayableError)
                throw displayableError
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
