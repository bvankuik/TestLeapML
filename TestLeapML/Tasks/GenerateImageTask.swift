//
//  GenerateImageTask.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 07/03/2023.
//

import LeapML
import OSLog

struct GenerateImageTask {
    static func run(requestBody: GenerateImageService.RequestBody, listViewModel: InferenceList.ViewModel) {
        Task {
            do {
                let newJob = try await GenerateImageService.call(requestBody: requestBody)
                if let index = await listViewModel.jobs.firstIndex(where: { $0.id == newJob.id }) {
                    // do nothing
                    os_log(
                        "At index %d, already found new inference with ID = %@",
                        log: .default,
                        type: .info,
                        index, newJob.id
                    )
                } else {
                    var queuedCount = 0
                    var sleepCount = 0
                    repeat {
                        guard sleepCount < 20 else {
                            os_log("Gave up trying to retrieve inference with ID = %@", log: .default, type: .debug, newJob.id)
                            break
                        }
                        os_log("Refreshing to get new inference with ID = %@", log: .default, type: .debug, newJob.id)
                        queuedCount = try await listViewModel.refresh()
                        if queuedCount > 0 {
                            try? await Task.sleep(for: .seconds(2))
                            sleepCount += 1
                            os_log("Sleepcount %d to wait for new inference with ID = %@", log: .default, type: .debug, sleepCount, newJob.id)
                        }
                    } while !Task.isCancelled

                    if queuedCount > 0 {
                        os_log("Gave up waiting for inference with ID = %@", log: .default, type: .debug, newJob.id)
                    }
                }
            } catch {
                os_log("%@", log: .default, type: .info, error.localizedDescription)
                throw DisplayableError("Error calling GenerateImageService:\n\(error.localizedDescription)")
            }
        }
    }
}
