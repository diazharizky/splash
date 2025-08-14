//
//  AuthService.swift
//  Splash
//
//  Created by Magnifico on 30/07/25.
//

import AuthenticationServices
import Foundation

private struct RequestTokenRequest: Encodable {
    let client_id: String
    let client_secret: String
    let redirect_uri: String
    let code: String
    let grant_type: String

    init(code: String) {
        self.client_id = "YQXwh1kLcPk2rv4eljqgoFgLQfKznvTO9e9RM20h7aw"
        self.client_secret = "AA03zKOJsBQi3SJHhOjWFyC1CtKiyDcANrlS4GRAmrw"
        self.redirect_uri = "splash://account-auth"
        self.code = code
        self.grant_type = "authorization_code"
    }
}

private struct RequestTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let refresh_token: String
    let scope: String
    let created_at: Int
    let user_id: Int
    let username: String
}

enum AuthServiceError: Error {
    case authenticationFailed
}

protocol AuthServiceProtocol {
    var isLoggedIn: Bool { get }
    var accessToken: String? { get }
    func requestToken(authCode: String) async throws
    func logout() throws
}

final class AuthService: AuthServiceProtocol {
    static let shared = AuthService(
        tokenStorageService: TokenStorageService.shared
    )

    private let tokenStorageService: TokenStorageServiceProtocol

    var isLoggedIn: Bool {
        do {
            let _ = try tokenStorageService.getAccessToken()
            return true
        } catch {
            return false
        }
    }

    var accessToken: String? {
        do {
            return try tokenStorageService.getAccessToken()
        } catch {
            return nil
        }
    }

    init(tokenStorageService: TokenStorageServiceProtocol) {
        self.tokenStorageService = tokenStorageService
        print("Initialize AuthService")
    }

    func requestToken(authCode: String) async throws {
        guard let url = URL(string: "https://unsplash.com/oauth/token") else {
            throw URLError(.badURL)
        }

        let body = RequestTokenRequest(code: authCode)
        guard let jsonData = try? JSONEncoder().encode(body) else {
            throw AuthServiceError.authenticationFailed
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(
            RequestTokenResponse.self,
            from: data
        )

        try tokenStorageService.setTokens(
            accessToken: response.access_token,
            refreshToken: response.refresh_token
        )
    }

    func logout() throws {
        try tokenStorageService.clearTokens()
    }

    deinit {
        print("Deinitialize AuthService")
    }
}
