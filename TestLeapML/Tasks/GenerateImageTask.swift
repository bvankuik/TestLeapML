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
                }
            } catch {
                os_log("%@", log: .default, type: .info, error.localizedDescription)
                throw DisplayableError("Error calling GenerateImageService:\n\(error.localizedDescription)")
            }
        }
    }
}
