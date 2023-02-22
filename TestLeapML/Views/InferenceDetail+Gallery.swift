//
//  InferenceDetail+Gallery.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/02/2023.
//

import SwiftUI

extension InferenceDetail {
    struct Gallery: View {
        let imageURLs: [URL?]
        
        var body: some View {
            TabView {
                ForEach(self.imageURLs, id: \.self) { imageURL in
                    AsyncImage(url: imageURL)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct InferenceDetail_Gallery_Previews: PreviewProvider {
    //  swiftlint:disable line_length
    private static var inferenceImages: [URL?] = [
        // Image by Arnel Hasanovic https://unsplash.com/@arnelhasanovic
        URL(string: "https://unsplash.com/photos/4oWSXdeAS2g/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYw&force=true&w=640"),
        // Image by Bagus Hernawan https://unsplash.com/@bhaguz
        URL(string: "https://unsplash.com/photos/A6JxK37IlPo/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYw&force=true&w=640"),
        // Image by Ben Kolde https://unsplash.com/@benkolde
        URL(string: "https://unsplash.com/photos/xdLXPic3Wfk/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYy&force=true&w=640")
    ]
    
    static var previews: some View {
        VStack {
            InferenceDetail.Gallery(imageURLs: Self.inferenceImages)
            List {
                HStack {
                    Text("ABC")
                    Spacer()
                    Text("DEF")
                }
            }
        }
    }
}
