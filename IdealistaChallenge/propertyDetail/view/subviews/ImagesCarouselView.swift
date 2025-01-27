//
//  ImagesCarouselView.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import SwiftUI

struct ImagesCarouselView: View {
    let imageUrls: [URL]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(imageUrls, id: \.self) { url in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 250)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 300, height: 250)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
