//
//  InferenceList+RowLabel.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/03/2023.
//

import SwiftUI
import LeapML

extension InferenceList {
    struct RowLabel: View {
        @EnvironmentObject private var refreshTask: RefreshTask
        let job: InferenceJob

        var body: some View {
            HStack(spacing: 4) {
                VStack {
                    Text(job.prompt)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text(job.createdAt.formatted(.dateTime))
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        if self.job.status == .queued {
                            Text("Queued")
                                .font(.caption)
                        }
                    }
                }
                progressView
            }
        }

        @ViewBuilder
        private var progressView: some View {
            if refreshTask.taskStatus.isLoading && job.status == .queued {
                ProgressView()
            }
        }
    }
}

struct InferenceList_RowLabel_Previews: PreviewProvider {
    static var refreshTask: RefreshTask {
        let rt = RefreshTask(inferenceListViewModel: InferenceList.ViewModel.mock)
        rt.taskStatus = .loading
        return rt
    }

    static var previews: some View {
        let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences").sortedNewestFirst()

        NavigationStack {
            List {
                InferenceList.RowLabel(job: jobs[0])
                NavigationLink(destination: EmptyView()) {
                    InferenceList.RowLabel(job: jobs[1])
                }
            }
        }
        .environmentObject(Self.refreshTask)
    }
}
