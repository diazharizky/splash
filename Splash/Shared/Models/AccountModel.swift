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
    let bio: String?

    var totalLikes: Int
    var totalPhotos: Int
    var totalCollections: Int

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

    mutating func increaseTotalPhotos() {
        totalPhotos += 1
    }

    mutating func decreaseTotalPhotos() {
        totalPhotos -= 1
    }

    mutating func increaseTotalCollections() {
        totalCollections += 1
    }

    mutating func decreaseTotalCollections() {
        totalCollections -= 1
    }
}
