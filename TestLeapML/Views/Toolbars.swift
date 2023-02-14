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
    @Binding var jobs: [InferenceJob]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("New") {
                self.isShowingNewImage.toggle()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Reload") {
                Task {
                    do {
                        self.jobs = try await ListInferenceService.call()
                    } catch {
                        os_log("%@", log: .default, type: .info, error.localizedDescription)
                        throw DisplayableError("Error calling list inferences:\n\(error.localizedDescription)")
                    }
                }
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
                    Toolbars(isShowingNewImage: .constant(false), jobs: .constant([]))
                }
        }
    }
}
