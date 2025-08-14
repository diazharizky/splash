//
//  UserLikedPhotosTabView.swift
//  Splash
//
//  Created by Magnifico on 03/08/25.
//

import SwiftUI

struct UserLikedPhotosTabView: View {
    @EnvironmentObject private var userLikedPhotosViewModel:
        UserLikedPhotosViewModel
    @EnvironmentObject private var accountViewModel: AccountViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach($userLikedPhotosViewModel.photos) { $photo in
                        PhotoCardView(photo: $photo, showLikedTag: false)
                    }
                }
            }
            .onAppear {
                if userLikedPhotosViewModel.photos.isEmpty {
                    Task {
                        if let username =
                            accountViewModel.account?.username
                        {
                            await userLikedPhotosViewModel.fetchPhotos(
                                username: username
                            )
                        } else {
                            print("Unable to fetch liked photos")
                        }
                    }
                }
            }
        }
        .onDisappear {
            print("UserLikedPhotosTabView is destroyed")
        }
    }
}
