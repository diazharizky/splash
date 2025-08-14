//
//  Unsplash.swift
//  Splash
//
//  Created by Magnifico on 29/07/25.
//

import Foundation

struct AccountModel {
    let username: String
    let name: String
    let email: String
    var totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let bio: String?

    init(
        username: String,
        name: String,
        email: String,
        totalLikes: Int,
        totalPhotos: Int,
        totalCollections: Int,
        bio: String? = nil
    ) {
        self.username = username
        self.name = name
        self.email = email
        self.totalLikes = totalLikes
        self.totalPhotos = totalPhotos
        self.totalCollections = totalCollections
        self.bio = bio
    }

    mutating func increaseTotalLikes() {
        totalLikes += 1
    }

    mutating func decreaseTotalLikes() {
        totalLikes -= 1
    }
}
