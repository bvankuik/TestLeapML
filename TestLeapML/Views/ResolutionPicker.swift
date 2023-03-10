//
//  ResolutionPicker.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 22/02/2023.
//

import SwiftUI

extension ResolutionPicker {
    struct Resolution: Identifiable, Hashable {
        internal init(description: String, width: Int, height: Int) {
            guard width % 8 == 0, height % 8 == 0 else {
                fatalError("Width and height must be multiples of 8")
            }
            self.description = description
            self.width = width
            self.height = height
        }
        
        let description: String
        let width: Int
        let height: Int
        var id: Int {
            self.hashValue
        }
        var sizeString: String {
            self == Self.emptySelection ? "" : "\(width)×\(height)"
        }
        static let emptySelection = Resolution(description: "", width: 0, height: 0)
    }
}

struct ResolutionPicker: View {
    static let resolutions: [Resolution] = [
        Resolution(description: "512×512", width: 512, height: 512),
        Resolution(description: "800×600", width: 800, height: 600),
        Resolution(description: "1024×768", width: 1024, height: 768),
        Resolution(description: "1024×1024", width: 1024, height: 1024)
    ]
    @Binding var selection: Resolution
    
    var body: some View {
        Picker(selection: self.$selection, label: Text("Resolution")) {
            ForEach(Self.resolutions, id: \.self) {
                Text($0.description)
            }
        }.pickerStyle(.segmented)
    }
}

struct ResolutionPicker_Previews: PreviewProvider {
    struct PreviewPicker: View {
        @State private var resolution = ResolutionPicker.Resolution.emptySelection
        
        var body: some View {
            VStack(spacing: 50) {
                ResolutionPicker(selection: self.$resolution)
                    .padding()
                    .border(Color.black)
                Text("Result: " + self.resolution.description)
            }
            .padding()
        }
    }
    
    static var previews: some View {
        PreviewPicker()
    }
}
