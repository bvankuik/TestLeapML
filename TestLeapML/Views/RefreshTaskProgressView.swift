//
//  RefreshTaskProgressView.swift
//  TestLeapML
//
//  Created by bartvk on 12/04/2023.
//

import SwiftUI

struct RefreshTaskProgressView: View {
    @EnvironmentObject private var refreshTask: RefreshTask

    var body: some View {
        switch self.refreshTask.taskStatus {
        case .loading:
            ProgressView()
        case .error:
            ErrorBar(error: self.makeErrorBinding())
        default:
            EmptyView()
        }
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

struct RefreshTaskProgressView_Previews: PreviewProvider {
    static private func makeRefreshTask(status: TaskStatus) -> RefreshTask {
        let rt = RefreshTask(inferenceListViewModel: InferenceList.ViewModel.mock)
        rt.taskStatus = status
        return rt
    }

    static var previews: some View {
        VStack(spacing: 20) {
            Color.gray.overlay(
                RefreshTaskProgressView()
            )
            .environmentObject(Self.makeRefreshTask(status: .error(DisplayableError("Error to demonstrate in Preview"))))

            Color.yellow.overlay(
                RefreshTaskProgressView()
            )
            .environmentObject(Self.makeRefreshTask(status: .loading))
        }
    }
}
