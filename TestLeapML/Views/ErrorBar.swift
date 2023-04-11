//
//  ErrorBar.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 14/02/2023.
//

import SwiftUI

struct ErrorBar: View {
    @Binding var error: Error?
    private var opacity: Double {
        self.error == nil ? 0 : 1
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(error?.localizedDescription ?? "No error")
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
        }.opacity(self.opacity).animation(.default, value: self.opacity)
    }
}

struct ErrorBar_Previews: PreviewProvider {
    struct Preview: View {
        private static let errorToShow = DisplayableError("Test error!")
        @State private var error: Error? = Self.errorToShow
        
        var body: some View {
            Color.white
                .overlay(
                    ErrorBar(error: self.$error)
                )
                .overlay(
                    Button("Show it") {
                        self.error = Self.errorToShow
                    }
                )
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
