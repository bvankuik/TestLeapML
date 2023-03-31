//
//  Toolbars.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI
import OSLog

struct Toolbars: ToolbarContent {
    @Environment(\.accessibilityEnabled) private var accessibilityEnabled
    @EnvironmentObject private var refreshTask: RefreshTask

    @Binding var isShowingNewImage: Bool
    @ObservedObject var listViewModel: InferenceList.ViewModel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                self.isShowingNewImage.toggle()
            } label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }
            .accessibilityLabel(Text("Create"))
            .accessibilityHint("Create new image")
        }
        if self.accessibilityEnabled {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    Task {
                        try? await self.refreshTask.runLoop()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
                .accessibilityLabel(Text("Refresh"))
                .accessibilityHint("Refresh list of images")
            }
        }
    }
}

struct Toolbars_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Text("Hello preview")
                .navigationTitle("Preview")
                .toolbar {
                    Toolbars(isShowingNewImage: .constant(false), listViewModel: InferenceList.ViewModel.mock)
                }
        }
    }
}
