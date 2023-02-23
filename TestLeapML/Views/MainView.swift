//
//  MainView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 23/02/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: InferenceList.ViewModel

    @State private var error: Error?
    @State private var isShowingNewImage = false

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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: InferenceList.ViewModel.mock)
    }
}
