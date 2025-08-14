//
//  DashboardView.swift
//  Splash
//
//  Created by Magnifico on 28/07/25.
//

import SwiftUI

private enum TabSelection {
    case explore, search, gallery, account
}

private struct TabBarButton: View {
    let icon: String
    let activeIcon: String
    let label: String
    let tab: TabSelection

    @Binding var currentActiveTab: TabSelection

    var body: some View {
        VStack(spacing: 4) {
            Image(
                systemName: currentActiveTab == tab ? activeIcon : icon
            )
            .font(.system(size: 21))
            .frame(minHeight: 26)
            Text(label).font(.system(size: 13))
        }
        .foregroundColor(currentActiveTab == tab ? .blue : .gray)
        .frame(maxWidth: .infinity)
        .onTapGesture { currentActiveTab = tab }
    }
}

struct DashboardView: View {
    @EnvironmentObject private var exploreViewModel: ExploreViewModel
    @EnvironmentObject private var accountViewModel: AccountViewModel

    @State private var currentActiveTab: TabSelection = .gallery

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    switch currentActiveTab {
                    case .account:
                        AccountTabView()
                    case .search:
                        SearchTabView()
                    case .gallery:
                        GalleryTabView()
                    default:
                        ExploreTabView()
                    }
                }

                Divider()

                HStack {
                    TabBarButton(
                        icon: "door.right.hand.closed",
                        activeIcon: "door.right.hand.open",
                        label: "Explore",
                        tab: .explore,
                        currentActiveTab: $currentActiveTab
                    )

                    TabBarButton(
                        icon: "magnifyingglass",
                        activeIcon: "sparkle.magnifyingglass",
                        label: "Search",
                        tab: .search,
                        currentActiveTab: $currentActiveTab
                    )

                    TabBarButton(
                        icon: "photo.on.rectangle",
                        activeIcon: "photo.on.rectangle.angled.fill",
                        label: "Gallery",
                        tab: .gallery,
                        currentActiveTab: $currentActiveTab
                    )

                    TabBarButton(
                        icon: "person.crop.rectangle.fill",
                        activeIcon: "person.text.rectangle.fill",
                        label: "Account",
                        tab: .account,
                        currentActiveTab: $currentActiveTab
                    )
                }
                .frame(height: 60)
            }
        }
        .onAppear {
            if accountViewModel.isLoggedIn {
                Task {
                    do {
                        try await accountViewModel.loadAccount()
                    } catch {
                        print("Unable to load account")
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
