//
//  PhotoCardView.swift
//  Splash
//
//  Created by Magnifico on 13/08/25.
//

import SwiftUI

struct PhotoCardView: View {
    let showLikedTag: Bool

    @Binding var photo: PhotoModel

    var body: some View {
        VStack {
            ZStack {
                if let image = photo.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    AsyncImage(url: photo.url) {
                        loadedImg in
                        loadedImg
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .onAppear {
                                if photo.image == nil {
                                    photo.setImage(loadedImg)
                                }
                            }
                    } placeholder: {
                        if let placeholder =
                            photo.placeholder
                        {
                            placeholder
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ProgressView()
                                .frame(
                                    minWidth: .infinity,
                                    minHeight: 300
                                )
                        }
                    }
                }
                if showLikedTag && photo.likedByUser {
                    VStack {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 21))
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}
