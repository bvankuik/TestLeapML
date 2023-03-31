//
//  NavigationContainer.swift
//  TestLeapML
//
//  Created by bartvk on 24/03/2023.
//

import SwiftUI
import OSLog

struct NavigationContainer: View {
    @EnvironmentObject private var refreshTask: RefreshTask
    let viewModel: InferenceList.ViewModel

    var body: some View {
        NavigationStack {
            InferenceListContainer(
                viewModel: self.viewModel,
                inferenceListHandler: {
                    try? await self.refreshTask.runLoop()
                }
            )
        }
    }
}
