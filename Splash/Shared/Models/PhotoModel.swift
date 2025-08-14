//
//  PhotoModel.swift
//  Splash
//
//  Created by Magnifico on 31/07/25.
//

import Foundation
import SwiftUI

struct PhotoModel: Identifiable {
    let id = UUID()
    let photoID: String
    let url: URL?
    let placeholder: Image?

    var likedByUser: Bool
    var image: Image?

    init(
        photoID: String,
        url urlStr: String,
        blurHash: String,
        likedByUser: Bool = false
    ) {
        self.photoID = photoID
        self.url = URL(string: urlStr) ?? nil
        self.likedByUser = likedByUser

        if let placeholderImage = UIImage(
            blurHash: blurHash,
            size: CGSize(width: 200, height: 200)
        ) {
            self.placeholder = Image(uiImage: placeholderImage)
        } else {
            self.placeholder = nil
        }
    }

    mutating func setImage(_ image: Image) {
        self.image = image
    }

    mutating func toggleLikedByUser() {
        likedByUser.toggle()
    }
}
