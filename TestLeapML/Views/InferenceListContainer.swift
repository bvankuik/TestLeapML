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
    
    @State private var isShowingNewImage = false
    
    var body: some View {
        InferenceList(viewModel: self.viewModel)
            .overlay(RefreshTaskProgressView())
            .overlay(EmptyLabel(visible: self.viewModel.jobs.isEmpty && !self.refreshTask.taskStatus.isLoading))
            .toolbar {
                Toolbars(
                    isShowingNewImage: self.$isShowingNewImage,
                    listViewModel: self.viewModel
                )
            }
            .sheet(isPresented: self.$isShowingNewImage) {
                NewImage(listViewModel: self.viewModel)
            }
    }
}

extension InferenceListContainer {
    struct EmptyLabel: View {
        let visible: Bool
        
        var body: some View {
            if self.visible {
                Text("No inferences found").font(.headline).italic().opacity(0.5)
            } else {
                EmptyView()
            }
        }
    }
}

struct InferenceListContainer_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @EnvironmentObject private var refreshTask: RefreshTask
        @ObservedObject var viewModel: InferenceList.ViewModel

        var body: some View {
            InferenceListContainer(viewModel: self.viewModel)
                .task {
                    self.refreshTask.taskStatus = .loading
                    try? await Task.sleep(for: Duration.seconds(2))
                    self.viewModel.jobs = InferenceList.ViewModel.mock.jobs
                    self.refreshTask.taskStatus = .idle
                }
        }
    }
    
    static let emptyViewModel = InferenceList.ViewModel()
    static private var viewModel = InferenceList.ViewModel.mock
    static private var refreshTaskWithError: RefreshTask = {
        let refreshTask = RefreshTask(inferenceListViewModel: Self.viewModel)
        refreshTask.taskStatus = .error(DisplayableError("Error to show in preview"))
        return refreshTask
    }()
    
    static var previews: some View {
        PreviewContainer(viewModel: InferenceList.ViewModel())
            .environmentObject(RefreshTask(inferenceListViewModel: self.viewModel))
        InferenceListContainer(viewModel: self.viewModel)
            .environmentObject(Self.refreshTaskWithError)
        InferenceListContainer(viewModel: Self.emptyViewModel)
            .environmentObject(RefreshTask(inferenceListViewModel: Self.emptyViewModel))
    }
}
