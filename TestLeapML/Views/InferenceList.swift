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
            /*@START_MENU_TOKEN@*/Text(job.id)/*@END_MENU_TOKEN@*/
        }
        .navigationTitle("Inference jobs")
    }
}

struct InferenceList_Previews: PreviewProvider {
    static let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")
    
    static var previews: some View {
        InferenceList(jobs: Self.jobs)
    }
}
