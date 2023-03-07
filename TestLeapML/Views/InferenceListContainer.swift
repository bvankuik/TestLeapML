//
//  InferenceListContainer.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 23/02/2023.
//

import SwiftUI
import LeapML

struct InferenceListContainer: View {
    @ObservedObject var viewModel: InferenceList.ViewModel
    
    @State private var error: Error?
    @State private var isShowingNewImage = false
    
    var body: some View {
        NavigationStack {
            ProgressContainer {
                InferenceList(viewModel: self.viewModel)
            } loader: {
                if ProcessInfo.isPreview {
                    try await Task.sleep(for: Duration.seconds(2))
                    let jobs = Utils.loadModel([InferenceJob].self, from: "ListInferences")
                    self.viewModel.jobs = jobs
                } else {
                    try await self.viewModel.refresh()
                }
            }
            .toolbar {
                Toolbars(
                    isShowingNewImage: self.$isShowingNewImage,
                    listViewModel: self.viewModel
                )
            }
            .sheet(isPresented: self.$isShowingNewImage) {
                NewImage(listViewModel: self.viewModel)
            }
            .overlay(ErrorBar(error: self.$error))
        }
    }
}

struct InferenceListContainer_Previews: PreviewProvider {
    static var previews: some View {
        InferenceListContainer(viewModel: InferenceList.ViewModel.mock)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
