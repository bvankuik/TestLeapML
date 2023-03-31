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
    let inferenceListHandler: () async -> Void
    
    @State private var error: Error?
    @State private var isShowingNewImage = false
    
    var body: some View {
        ProgressContainer {
            InferenceList(viewModel: self.viewModel)
        } loader: {
            await inferenceListHandler()
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

struct InferenceListContainer_Previews: PreviewProvider {
    struct Preview: View {
        @ObservedObject var viewModel: InferenceList.ViewModel
        
        var body: some View {
            InferenceListContainer(viewModel: self.viewModel, inferenceListHandler: self.handler)
        }
        
        private func handler() async {
            try? await Task.sleep(for: Duration.seconds(2))
            self.viewModel.jobs = InferenceList.ViewModel.mock.jobs
        }
    }
    
    static private var viewModel = InferenceList.ViewModel.mock
    
    static var previews: some View {
        Preview(viewModel: self.viewModel)
            .environmentObject(RefreshTask(inferenceListViewModel: self.viewModel))
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
