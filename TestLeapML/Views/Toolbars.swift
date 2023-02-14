//
//  Toolbars.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import SwiftUI

struct Toolbars: ToolbarContent {
    @Binding var isShowingNewImage: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("New") {
                self.isShowingNewImage.toggle()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Reload") {
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
                    Toolbars(isShowingNewImage: .constant(false))
                }
        }
    }
}
