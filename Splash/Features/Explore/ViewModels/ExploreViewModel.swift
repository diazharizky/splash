//
//  ExploreViewModel.swift
//  Splash
//
//  Created by Magnifico on 30/07/25.
//

import Foundation
import SwiftUI

protocol ExploreViewModelProtocol {
    func loadPhotos() async
    func likePhoto(id: String) async
}

@MainActor
final class ExploreViewModel: ExploreViewModelProtocol, ObservableObject {
    private let unsplashPhotosService: UnsplashUserPhotosServiceProtocol

    @Published var photos: [PhotoModel] = []

    init(unsplashPhotosService: UnsplashUserPhotosServiceProtocol) {
        self.unsplashPhotosService = unsplashPhotosService
        print("Initialize ExploreViewModel")
    }

    func loadPhotos() async {
        do {
            let photos = try await unsplashPhotosService.getPhotos(page: 1)
            var photoModels: [PhotoModel] = []
            for photo in photos {
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
            print("Error loading photos: \(error.localizedDescription)")
        }
    }

    func likePhoto(id: String) async {
        do {
            try await unsplashPhotosService.likePhoto(id: id)
        } catch {
            print("Error liking photo: \(error.localizedDescription)")
        }
    }

    func unlikePhoto(id: String) async {
        do {
            try await unsplashPhotosService.unlikePhoto(id: id)
        } catch {
            print("Error unliking photo: \(error.localizedDescription)")
        }
    }

    deinit {
        print("Deinitialize ExploreViewModel")
    }
}
