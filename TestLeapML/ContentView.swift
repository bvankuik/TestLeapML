//
//  ContentView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import OSLog
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = InferenceList.ViewModel()
    
    var body: some View {
        InferenceListContainer(viewModel: self.viewModel)
            .environmentObject(RefreshTask(inferenceListViewModel: self.viewModel))
    }
}
