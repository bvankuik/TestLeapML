//
//  InferenceList.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI

struct InferenceList: View {
    let jobs: [InferenceJob]
    
    var body: some View {
        List(jobs) { job in
            NavigationLink(destination: {
                InferenceDetail(inferenceJob: job)
            }, label: {
                Text(job.id)
                    .lineLimit(1)
            })
        }
        .navigationTitle("Inference jobs")
    }
}

struct InferenceList_Previews: PreviewProvider {
    static let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")
    
    static var previews: some View {
        NavigationStack {
            InferenceList(jobs: Self.jobs)
        }
    }
}
