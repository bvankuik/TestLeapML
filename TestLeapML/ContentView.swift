//
//  ContentView.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: self.buttonAction) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
    }
    
    private func buttonAction() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError()
        }
        print("apiKey=\(apiKey)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
