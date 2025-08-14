//
//  AccountService.swift
//  Splash
//
//  Created by Magnifico on 02/08/25.
//

import Foundation

protocol AccountServiceProtocol {
    func getLoggedAccount() async throws -> UnsplashAccountModel
}

final class AccountService: AccountServiceProtocol {
    static let shared = AccountService(authService: AuthService.shared)

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        print("Initialize AccountService")
    }

    func getLoggedAccount() async throws -> UnsplashAccountModel {
        guard let url = URL(string: "https://api.unsplash.com/me") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "Bearer \(authService.accessToken!)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, _) = try await URLSession.shared.data(for: request)
        let account = try JSONDecoder().decode(
            UnsplashAccountModel.self,
            from: data
        )
        return account
    }

    deinit {
        print("Deinitialize AccountService")
    }
}
