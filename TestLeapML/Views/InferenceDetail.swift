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
        List {
            HStack {
                Text("Prompt")
                Spacer()
                Text(self.inferenceJob.prompt)
            }
            HStack {
                Text("Negative prompt")
                Spacer()
                Text(self.inferenceJob.negativePrompt)
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
        .navigationTitle("Job \(self.inferenceJob.id)")
    }
    
}

struct InferenceDetail_Previews: PreviewProvider {
    static let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")

    static var previews: some View {
        InferenceDetail(inferenceJob: jobs[0])
    }
}