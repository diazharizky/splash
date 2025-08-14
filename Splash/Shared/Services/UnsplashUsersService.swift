//
//  UnsplashUsersService.swift
//  Splash
//
//  Created by Magnifico on 12/08/25.
//

import Foundation

protocol UnsplashUsersServiceProtocol {
    func getLikedPhotos(username: String) async throws -> [UnsplashPhotoModel]
    func getCollections(username: String) async throws
        -> [UnsplashCollectionModel]
}

final class UnsplashUsersService: UnsplashUsersServiceProtocol {
    static let shared = UnsplashUsersService(
        authService: AuthService.shared,
        accountService: AccountService.shared
    )

    private let authService: AuthServiceProtocol
    private let accountService: AccountServiceProtocol

    init(
        authService: AuthServiceProtocol,
        accountService: AccountServiceProtocol
    ) {
        self.authService = authService
        self.accountService = accountService
    }

    func getLikedPhotos(username: String) async throws -> [UnsplashPhotoModel] {
        guard
            let components = URLComponents(
                string: "https://api.unsplash.com/users/\(username)/likes"
            )
        else {
            return []
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(authService.accessToken!)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            if (200..<300).contains(httpResponse.statusCode) {
                print("Success getting photos")
                return try JSONDecoder().decode(
                    [UnsplashPhotoModel].self,
                    from: data
                )
            } else {
                print("Error: \(httpResponse.statusCode)")
            }
        }
        return []
    }

    func getCollections(username: String) async throws
        -> [UnsplashCollectionModel]
    {
        guard
            let components = URLComponents(
                string: "https://api.unsplash.com/users/\(username)/collections"
            )
        else {
            return []
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(authService.accessToken!)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            if (200..<300).contains(httpResponse.statusCode) {
                print("Success getting collections")
                return try JSONDecoder().decode(
                    [UnsplashCollectionModel].self,
                    from: data
                )
            } else {
                print("Error: \(httpResponse.statusCode)")
            }
        }
        return []
    }
}
