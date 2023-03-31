//
//  InferenceList.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import OSLog
import SwiftUI
import LeapML

struct InferenceList: View {
    @EnvironmentObject private var refreshTask: RefreshTask
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(self.viewModel.jobs) { job in
            if job.status == .finished {
                NavigationLink(destination: {
                    InferenceDetail(inferenceJob: job)
                }, label: {
                    RowLabel(job: job)
                })
            } else {
                RowLabel(job: job)
            }
        }
        .refreshable {
            Task {
                do {
                    try await self.refreshTask.runLoop()
                } catch {
                    os_log("Failed pull-to-refresh: %@", log: .default, type: .info, error.localizedDescription)
                }
            }
        }
        .navigationTitle("Inference jobs")
    }
}

struct InferenceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InferenceList(viewModel: InferenceList.ViewModel.mock)
        }
    }
}
