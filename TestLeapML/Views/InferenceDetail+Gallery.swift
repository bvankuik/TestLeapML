//
//  InferenceDetail+Gallery.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 21/02/2023.
//

import SwiftUI

extension InferenceDetail {
    struct Gallery: View {
        let images: [InferenceImage]
        
        var body: some View {
            TabView {
                ForEach(self.images) { image in
                    AsyncImage(url: image.url)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct InferenceDetail_Gallery_Previews: PreviewProvider {
    private static var inferenceImages: [InferenceImage] = {
        [
            // Image by Arnel Hasanovic https://unsplash.com/@arnelhasanovic
            InferenceImage(
                id: "1",
                uri: "https://unsplash.com/photos/4oWSXdeAS2g/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYw&force=true&w=640",
                createdAt: Date().addingTimeInterval(-3600)
            ),
            // Image by Bagus Hernawan https://unsplash.com/@bhaguz
            InferenceImage(
                id: "2",
                uri: "https://unsplash.com/photos/A6JxK37IlPo/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYw&force=true&w=640",
                createdAt: Date().addingTimeInterval(-2*3600)
            ),
            // Image by Ben Kolde https://unsplash.com/@benkolde
            InferenceImage(
                id: "3",
                uri: "https://unsplash.com/photos/xdLXPic3Wfk/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjc2OTcyMTYy&force=true&w=640",
                createdAt: Date().addingTimeInterval(-3*3600)
            ),
        ]
    }()
    
    static var previews: some View {
        InferenceDetail.Gallery(images: Self.inferenceImages)
    }
}
