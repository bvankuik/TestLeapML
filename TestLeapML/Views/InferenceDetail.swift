//
//  InferenceDetail.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 14/02/2023.
//

import SwiftUI

struct InferenceDetail: View {
    let inferenceJob: InferenceJob
    var body: some View {
        VStack(spacing: 0) {
            Gallery(imageURLs: self.inferenceJob.images.map { $0.url })
            List {
                HStack {
                    Text("Prompt")
                    Spacer()
                    Text(self.inferenceJob.prompt)
                }
                HStack {
                    Text("Negative prompt")
                    Spacer()
                    Text(self.inferenceJob.negativePrompt.dashIfEmpty)
                }
                HStack {
                    Text("Status")
                    Spacer()
                    Text(self.inferenceJob.status)
                }
                HStack {
                    Text("Width × Height")
                    Spacer()
                    Text("\(self.inferenceJob.width)×\(self.inferenceJob.height)")
                }
                HStack {
                    Text("Steps")
                    Spacer()
                    Text(String(describing: self.inferenceJob.steps))
                }
                HStack {
                    Text("Prompt strength")
                    Spacer()
                    Text(String(describing: self.inferenceJob.promptStrength))
                }
                HStack {
                    Text("Created")
                    Spacer()
                    Text(String(describing: self.inferenceJob.createdAt))
                }
            }
        }
        .navigationTitle(self.inferenceJob.prompt)
    }
    
}

struct InferenceDetail_Previews: PreviewProvider {
    static let job: InferenceJob = {
        let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")
        if let index = jobs.firstIndex(where: { $0.id == "247ab4a1-8693-4939-aff9-d2decd111a8c" }) {
            return jobs[index]
        } else {
            return jobs[0]
        }
    }()
    
    static var previews: some View {
        NavigationStack {
            InferenceDetail(inferenceJob: Self.job)
        }
    }
}
