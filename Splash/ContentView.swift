//
//  ContentView.swift
//  Splash
//
//  Created by Magnifico on 28/07/25.
//

import SwiftUI

struct DashboardViewLoggedInWrapper: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel

    @StateObject private var exploreViewModel = ExploreViewModel(
        unsplashPhotosService: UnsplashUserPhotosService.shared
    )
    @StateObject private var userPhotosViewModel = UserPhotosViewModel(
        authService: AuthService.shared
    )
    @StateObject private var userLikedPhotosViewModel =
        UserLikedPhotosViewModel(
            unsplashUsersService: UnsplashUsersService.shared
        )
    @StateObject private var userCollectionsViewModel =
        UserCollectionsViewModel(
            authService: AuthService.shared
        )

    var body: some View {
        DashboardView()
            .environmentObject(accountViewModel)
            .environmentObject(exploreViewModel)
            .environmentObject(userPhotosViewModel)
            .environmentObject(userLikedPhotosViewModel)
            .environmentObject(userCollectionsViewModel)
    }
}

struct DashboardViewNotLoggedInWrapper: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel

    @StateObject private var exploreViewModel = ExploreViewModel(
        unsplashPhotosService: UnsplashUserPhotosService.shared
    )

    var body: some View {
        DashboardView()
            .environmentObject(accountViewModel)
            .environmentObject(exploreViewModel)
    }
}

struct ContentView: View {
    @StateObject private var accountViewModel = AccountViewModel(
        authService: AuthService.shared,
        accountService: AccountService.shared
    )

    var body: some View {
        if accountViewModel.isLoggedIn {
            DashboardViewLoggedInWrapper()
                .environmentObject(accountViewModel)
        } else {
            DashboardViewNotLoggedInWrapper()
                .environmentObject(accountViewModel)
        }
    }
}
