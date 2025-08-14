//
//  ExploreTabView.swift
//  Splash
//
//  Created by Magnifico on 29/07/25.
//

import SwiftUI
import UIKit

struct ExploreTabView: View {
    @EnvironmentObject private var exploreViewModel: ExploreViewModel
    @EnvironmentObject private var accountViewModel: AccountViewModel
    @EnvironmentObject private var userLikedPhotosViewModel:
        UserLikedPhotosViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach($exploreViewModel.photos) { $photo in
                        PhotoCardView(photo: $photo, showLikedTag: true)
                            .onTapGesture(count: 2) {
                                if accountViewModel.isLoggedIn {
                                    if !photo.likedByUser {
                                        likePhoto(photoID: photo.photoID)
                                        userLikedPhotosViewModel.addPhoto(photo)
                                        accountViewModel.increaseLikesCount()
                                    } else {
                                        unlikePhoto(photoID: photo.photoID)
                                        userLikedPhotosViewModel.removePhoto(
                                            photo
                                        )
                                        accountViewModel.decreaseLikesCount()
                                    }
                                    photo.toggleLikedByUser()
                                } else {
                                    print("Please log in")
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            if exploreViewModel.photos.isEmpty {
                Task {
                    await exploreViewModel.loadPhotos()
                }
            }
        }
        .onDisappear {
            print("ExploreTabView disappeared")
        }
    }

    func likePhoto(photoID: String) {
        Task {
            await exploreViewModel.likePhoto(id: photoID)
        }
    }

    func unlikePhoto(photoID: String) {
        Task {
            await exploreViewModel.unlikePhoto(id: photoID)
        }
    }
}
