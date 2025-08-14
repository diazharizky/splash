//
//  AccountDetailView.swift
//  Splash
//
//  Created by Magnifico on 02/08/25.
//

import SwiftUI

private enum TabSelection {
    case photos, likedPhotos, collections
}

private struct TabBarButton: View {
    let icon: String
    let activeIcon: String
    let tab: TabSelection

    @Binding var selectedTab: TabSelection

    var body: some View {
        VStack(spacing: 4) {
            Image(
                systemName: selectedTab == tab ? activeIcon : icon
            )
            .font(.system(size: 21))
            .frame(minHeight: 26)
        }
        .foregroundColor(selectedTab == tab ? .blue : .gray)
        .frame(maxWidth: .infinity)
        .onTapGesture { selectedTab = tab }
    }
}

struct AccountDetailView: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel

    @State private var selectedTab: TabSelection = .photos

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 80))
                        .padding(.horizontal, 10)
                    VStack(alignment: .leading) {
                        Text(accountViewModel.account?.username ?? "").font(
                            .headline
                        )
                        if let bio = accountViewModel.account?.bio {
                            Text(bio).font(.subheadline)
                        }

                        NavigationLink(
                            destination: EditProfileView(
                                account: accountViewModel.account!
                            )
                        ) {
                            Text("Edit Profile")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 12)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.top, 2)
                    }
                    Button("Logout") {
                        accountViewModel.logout()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                HStack {
                    VStack {
                        Text(String(accountViewModel.account?.totalPhotos ?? 0))
                            .font(
                                .title2
                            )
                        Text("Photos").font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text(String(accountViewModel.account?.totalLikes ?? 0))
                            .font(.title2)
                        Text("Likes").font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text(
                            String(
                                accountViewModel.account?.totalCollections ?? 0
                            )
                        ).font(.title2)
                        Text("Collections").font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 4)
                VStack(spacing: 0) {
                    HStack {
                        TabBarButton(
                            icon: "square.grid.3x3",
                            activeIcon: "square.grid.3x3.fill",
                            tab: .photos,
                            selectedTab: $selectedTab
                        )
                        TabBarButton(
                            icon: "heart",
                            activeIcon: "heart.fill",
                            tab: .likedPhotos,
                            selectedTab: $selectedTab
                        )
                        TabBarButton(
                            icon: "photo.stack",
                            activeIcon: "photo.stack.fill",
                            tab: .collections,
                            selectedTab: $selectedTab
                        )
                    }
                    .padding(.vertical, 10)
                    Divider()
                    TabView(selection: $selectedTab) {
                        UserPhotosTabView().tag(TabSelection.photos)
                        UserLikedPhotosTabView().tag(TabSelection.likedPhotos)
                        UserCollectionsTabView().tag(TabSelection.collections)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            }
            .padding(.top, 20)
        }
    }
}
