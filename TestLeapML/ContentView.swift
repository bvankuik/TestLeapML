//
//  ContentView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingNewImage = false
    private var jobs: [InferenceJob] = []
    
    var body: some View {
        NavigationStack {
            InferenceList(jobs: self.jobs)
                .toolbar {
                    Toolbars(isShowingNewImage: self.$isShowingNewImage)
                }
                .sheet(isPresented: self.$isShowingNewImage) {
                    NewImage()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
