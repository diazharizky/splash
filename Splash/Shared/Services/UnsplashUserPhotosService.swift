//
//  UnsplashUserPhotosService.swift
//  Splash
//
//  Created by Magnifico on 30/07/25.
//

import Foundation

protocol UnsplashUserPhotosServiceProtocol {
    func getPhotos(page: Int) async throws -> [UnsplashPhotoModel]
    func likePhoto(id: String) async throws
    func unlikePhoto(id: String) async throws
}

final class UnsplashUserPhotosService: UnsplashUserPhotosServiceProtocol {
    static let shared = UnsplashUserPhotosService(
        authService: AuthService.shared
    )

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        print("Initialize UnsplashUserPhotosService")
    }

    func getPhotos(page: Int) async throws -> [UnsplashPhotoModel] {
        guard
            var components = URLComponents(
                string: "https://api.unsplash.com/photos"
            )
        else {
            return []
        }

        components.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        if !authService.isLoggedIn {
            components.queryItems?.append(
                URLQueryItem(
                    name: "client_id",
                    value: "YQXwh1kLcPk2rv4eljqgoFgLQfKznvTO9e9RM20h7aw"
                )
            )
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if authService.isLoggedIn {
            request.setValue(
                "Bearer \(authService.accessToken!)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([UnsplashPhotoModel].self, from: data)
    }

    func likePhoto(id: String) async throws {
        if !authService.isLoggedIn {
            return
        }

        guard
            let components = URLComponents(
                string: "https://api.unsplash.com/photos/\(id)/like"
            )
        else {
            return
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "Bearer \(authService.accessToken!)",
            forHTTPHeaderField: "Authorization"
        )

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            if (200..<300).contains(httpResponse.statusCode) {
                print("Success")
            } else {
                print("Error: \(httpResponse.statusCode)")
            }
        }
    }

    func unlikePhoto(id: String) async throws {
        if !authService.isLoggedIn {
            return
        }

        guard
            let components = URLComponents(
                string: "https://api.unsplash.com/photos/\(id)/like"
            )
        else {
            return
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(
            "Bearer \(authService.accessToken!)",
            forHTTPHeaderField: "Authorization"
        )

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            if (200..<300).contains(httpResponse.statusCode) {
                print("Success")
            } else {
                print("Error: \(httpResponse.statusCode)")
            }
        }
    }

    deinit {
        print("Deinitialize UnsplashUserPhotosService")
    }
}
