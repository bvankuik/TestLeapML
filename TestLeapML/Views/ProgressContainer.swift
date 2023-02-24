//
//  ProgressContainer.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 24/02/2023.
//

import SwiftUI

struct ProgressContainer<Content: View, Model>: View {
    enum LoadState {
        case loading
        case loaded(Model)
        case error(Error)
    }

    @ViewBuilder let content: (Model) -> Content
    let loader: () async throws -> Model

    @State private var loadState = LoadState.loading

    var body: some View {
        ZStack {
            Color.clear
            switch self.loadState {
            case .loading: ProgressView()
            case .loaded(let model): self.content(model)
            case .error(let error): Text(error.localizedDescription)
            }
        }
        .task {
            do {
                self.loadState = .loaded(try await self.loader())
            } catch {
                self.loadState = .error(error)
            }
        }
    }
}

struct ProgressContainer_Previews: PreviewProvider {
    struct PreviewViewModel {
        static func call() async throws -> [String] {
            try! await Task.sleep(for: Duration.seconds(2))
            return (0..<10).map { "Row \($0)" }
        }
    }
    
    struct PreviewViewModelThrowingError {
        static func call() async throws -> [String] {
            try! await Task.sleep(for: Duration.seconds(1))
            throw EncodingError.invalidValue(42, .init(codingPath: [], debugDescription: "Something wrong"))
        }
    }
    
    struct LoadedList: View {
        let strings: [String]
        
        var body: some View {
            List(self.strings, id: \.self) { string in
                Text(string)
            }
        }
    }
    
    struct Preview: View {
        var body: some View {
            VStack {
                ProgressContainer { strings in
                    LoadedList(strings: strings)
                } loader: {
                    try await PreviewViewModel.call()
                }
                Divider()
                ProgressContainer { strings in
                    LoadedList(strings: strings)
                } loader: {
                    try await PreviewViewModelThrowingError.call()
                }
            }
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
