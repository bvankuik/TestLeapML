//
//  ErrorBar.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 14/02/2023.
//

import SwiftUI

struct ErrorBar: View {
    @Binding var error: Error?
    
    var body: some View {
        if let error {
            VStack {
                Spacer()
                HStack {
                    Text(error.localizedDescription)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .overlay(
                            HStack {
                                Spacer()
                                Button("Close") {
                                    self.error = nil
                                }
                                .padding()
                            }
                        )
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct ErrorBar_Previews: PreviewProvider {
    struct Preview: View {
        @State private var error: Error? = DisplayableError("Test error!")
        
        var body: some View {
            Color.white
                .overlay(
                    ErrorBar(error: self.$error)
                )
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
