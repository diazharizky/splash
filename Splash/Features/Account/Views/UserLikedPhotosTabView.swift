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

    @Binding var isLoading: Bool

    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach($userLikedPhotosViewModel.photos) { $photo in
                        PhotoCardView(showLikedTag: false, photo: $photo)
                    }
                }
            }
            .onAppear {
                if userLikedPhotosViewModel.photos.isEmpty {
                    Task {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isLoading = true
                        }
                        if let username =
                            accountViewModel.account?.username
                        {
                            await userLikedPhotosViewModel.fetchPhotos(
                                username: username
                            )
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isLoading = false
                            }
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

#Preview {
    let userLikedPhotosViewModel = UserLikedPhotosViewModel(
        unsplashUsersService: UnsplashUsersService.shared
    )
    let accountViewModel = AccountViewModel(
        authService: AuthService.shared,
        accountService: AccountService.shared
    )
    UserLikedPhotosTabView(isLoading: .constant(true))
        .environmentObject(userLikedPhotosViewModel)
        .environmentObject(accountViewModel)
}
