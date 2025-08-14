//
//  UnsplashModels.swift
//  Splash
//
//  Created by Magnifico on 13/08/25.
//

import Foundation

struct UnsplashAccountSocialsModel: Decodable {
    let instagram_username: String?
    let portfolio_url: String?
    let twitter_username: String?
}

struct UnsplashAccountProfileImageModel: Decodable {
    let small: String?
    let medium: String?
    let large: String?
}

struct UnsplashAccountBadgeModel: Decodable {
    let title: String?
    let primary: Bool?
    let slug: String?
    let link: String?
}

struct UnsplashAccountLinksModel: Decodable {
    let `self`: String?
    let html: String?
    let photos: String?
    let likes: String?
    let portfolio: String?
}

struct UnsplashAccountModel: Decodable {
    let id: String?
    let username: String?
    let name: String?
    let first_name: String?
    let last_name: String?
    let instagram_username: String?
    let twitter_username: String?
    let portfolio_url: String?
    let bio: String?
    let location: String?
    let total_likes: Int?
    let total_photos: Int?
    let total_collections: Int?
    let downloads: Int?
    let socials: UnsplashAccountSocialsModel?
    let profile_image: UnsplashAccountProfileImageModel?
    let badge: UnsplashAccountBadgeModel?
    let links: UnsplashAccountLinksModel?
}

struct UnsplashCollectionModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let total_photos: Int
    let user: UnsplashAccountModel
}

struct UnsplashPhotoURLsModel: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}

struct UnsplashPhotoModel: Decodable, Identifiable {
    let id: String
    let slug: String
    let width: Int?
    let height: Int?
    let color: String?
    let blur_hash: String
    let likes: Int?
    let liked_by_user: Bool?
    let description: String?
    let urls: UnsplashPhotoURLsModel
    let asset_type: String?
}
