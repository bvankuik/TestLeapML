//
//  InferenceListContainer.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 23/02/2023.
//

import SwiftUI
import LeapML

struct InferenceListContainer: View {
    @EnvironmentObject private var refreshTask: RefreshTask
    @ObservedObject var viewModel: InferenceList.ViewModel
    let inferenceListHandler: () async -> Void
    
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
        .overlay(ErrorBar(error: self.makeErrorBinding()))
    }
    
    private func makeErrorBinding() -> Binding<Error?> {
        Binding<Error?>(
            get: {
                switch self.refreshTask.taskStatus {
                case .error(let error):
                    return error
                default:
                    return nil
                }
            },
            set: { newValue in
                if newValue == nil {
                    self.refreshTask.taskStatus = .idle
                }
            }
        )
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
    static private var refreshTaskWithError: RefreshTask = {
        let refreshTask = RefreshTask(inferenceListViewModel: Self.viewModel)
        refreshTask.taskStatus = .error(DisplayableError("Error to show in preview"))
        return refreshTask
    }()
    
    static var previews: some View {
        Preview(viewModel: self.viewModel)
            .environmentObject(RefreshTask(inferenceListViewModel: self.viewModel))
            .previewLayout(.fixed(width: 300, height: 300))
        Preview(viewModel: self.viewModel)
            .environmentObject(Self.refreshTaskWithError)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
