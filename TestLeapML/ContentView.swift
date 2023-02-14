//
//  ContentView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingNewImage = false
    @State private var jobs: [InferenceJob] = []
    @State private var error: Error?
    
    var body: some View {
        NavigationStack {
            InferenceList(jobs: self.jobs)
                .toolbar {
                    Toolbars(
                        isShowingNewImage: self.$isShowingNewImage,
                        jobs: self.$jobs
                    )
                }
                .sheet(isPresented: self.$isShowingNewImage) {
                    NewImage()
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
