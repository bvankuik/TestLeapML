//
//  RefreshTask.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/03/2023.
//

import SwiftUI
import OSLog
import LeapML

@MainActor class RefreshTask: ObservableObject, HasTaskStatus {
    let inferenceListViewModel: InferenceList.ViewModel
    @Published var taskStatus = TaskStatus.idle
    
    init(inferenceListViewModel: InferenceList.ViewModel) {
        self.inferenceListViewModel = inferenceListViewModel
    }
    
    func runLoop() async {
        var queuedCount = 0
        var sleepCount = 0
        repeat {
            guard sleepCount < 20 else {
                self.taskStatus = .error(DisplayableError("After many retries, failed to get the result"))
                os_log("Gave up refreshing, count reached \(sleepCount)")
                break
            }
            os_log("Refresh task submitting")
            
            do {
                queuedCount = try await self.refresh()
                if queuedCount == 0 {
                    self.taskStatus = .success
                    os_log("Nothing to refresh anymore")
                    break
                } else {
                    self.taskStatus = .idle
                    try? await Task.sleep(for: .seconds(2))
                    sleepCount += 1
                    os_log("Sleepcount %d")
                }
            } catch {
                self.taskStatus = .error(error)
            }
        } while !Task.isCancelled && queuedCount > 0
    }
    
    private func refresh() async throws -> Int {
        do {
            self.taskStatus = .loading
            let jobs = try await ListInferenceService.call()
            self.inferenceListViewModel.jobs = jobs.sortedNewestFirst()
            let queuedCount = jobs.filter { $0.status == .queued }.count
            return queuedCount
        } catch {
            os_log("%@", log: .default, type: .info, error.localizedDescription)
            throw DisplayableError("Error calling list inferences:\n\(error.localizedDescription)")
        }
    }
}
