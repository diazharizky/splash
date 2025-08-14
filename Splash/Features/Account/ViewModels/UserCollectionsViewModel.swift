//
//  UserCollectionsViewModel.swift
//  Splash
//
//  Created by Magnifico on 12/08/25.
//

import Foundation

protocol UserCollectionsViewModelProtocol {
    func fetchCollections() async
}

@MainActor
final class UserCollectionsViewModel: UserCollectionsViewModelProtocol,
    ObservableObject
{
    private let authService: AuthServiceProtocol

    @Published private(set) var collections: [UnsplashCollectionModel] = []

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        print("Initialize UserCollectionsViewModel")
    }

    func fetchCollections() async {}

    deinit {
        print("Deinitialize UserCollectionsViewModel")
    }
}
