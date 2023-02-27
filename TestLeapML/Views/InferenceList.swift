//
//  InferenceList.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI

extension InferenceList {
    struct RowLabel: View {
        let job: InferenceJob
        
        var body: some View {
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
        }
    }
}

struct InferenceList: View {
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
