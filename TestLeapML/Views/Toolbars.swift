//
//  Toolbars.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI
import OSLog

struct Toolbars: ToolbarContent {
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
//        ToolbarItem(placement: .primaryAction) {
//            Button {
//                self.listViewModel.refresh()
//            } label: {
//                Image(systemName: "arrow.clockwise")
//                    .imageScale(.large)
//            }
//            .accessibilityLabel(Text("Reload"))
//            .accessibilityHint("Refresh list of images")
//        }
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
