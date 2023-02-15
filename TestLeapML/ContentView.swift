//
//  ContentView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import OSLog
import SwiftUI

struct ContentView: View {
    @State private var isShowingNewImage = false
    @StateObject private var viewModel = InferenceList.ViewModel()
    @State private var jobs: [InferenceJob] = []
    @State private var error: Error?
    
    var body: some View {
        NavigationStack {
            InferenceList(viewModel: self.viewModel)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
