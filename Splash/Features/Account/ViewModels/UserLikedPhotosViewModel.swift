//
//  UserLikedPhotosViewModel.swift
//  Splash
//
//  Created by Magnifico on 13/08/25.
//

import Foundation

protocol UserLikedPhotosProtocol {
    func fetchPhotos(username: String) async
}

@MainActor
final class UserLikedPhotosViewModel: UserLikedPhotosProtocol, ObservableObject
{
    private let unsplashUsersService: UnsplashUsersServiceProtocol

    @Published var photos: [PhotoModel] = []

    init(unsplashUsersService: UnsplashUsersServiceProtocol) {
        self.unsplashUsersService = unsplashUsersService
        print("Initialize UserLikedPhotosViewModel")
    }

    func fetchPhotos(username: String) async {
        do {
            let likedPhotos = try await unsplashUsersService.getLikedPhotos(
                username: username
            )
            var photoModels: [PhotoModel] = []
            for photo in likedPhotos {
                photoModels.append(
                    PhotoModel(
                        photoID: photo.id,
                        url: photo.urls.small,
                        blurHash: photo.blur_hash,
                        likedByUser: photo.liked_by_user ?? false
                    )
                )
            }
            self.photos = photoModels
        } catch {
            print("Unable to fetch liked photos")
        }
    }

    func addPhoto(_ photo: PhotoModel) {
        if !photos.isEmpty {
            photos.insert(photo, at: 0)
        }
    }

    func removePhoto(_ photo: PhotoModel) {
        photos.removeAll { $0.photoID == photo.photoID }
    }

    deinit {
        print("Deinitialize UserLikedPhotosViewModel")
    }
}
