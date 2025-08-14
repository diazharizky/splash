//
//  TokenStorageService.swift
//  Splash
//
//  Created by Magnifico on 31/07/25.
//

import Foundation

enum TokenStorageServiceError: Error {
    case setTokenFailed
    case getAccessTokenFailed
    case setAccessTokenFailed
    case getRefreshTokenFailed
    case setRefreshTokenFailed
    case removeTokenFailed
}

protocol TokenStorageServiceProtocol {
    func getAccessToken() throws -> String
    func setTokens(accessToken: String, refreshToken: String) throws
    func clearTokens() throws
}

final class TokenStorageService: TokenStorageServiceProtocol {
    static let shared = TokenStorageService()

    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"

    init() {
        print("Initialize TokenStorageService")
    }

    func setTokens(accessToken: String, refreshToken: String) throws {
        try setAccessToken(accessToken)
        try setRefreshToken(refreshToken)
    }

    func clearTokens() throws {
        try remove(key: accessTokenKey)
        try remove(key: refreshTokenKey)
    }

    func getAccessToken() throws -> String {
        guard let token = get(accessTokenKey) else {
            throw TokenStorageServiceError.getAccessTokenFailed
        }
        return token
    }

    private func setAccessToken(_ token: String) throws {
        do {
            try set(key: accessTokenKey, token: token)
        } catch TokenStorageServiceError.setTokenFailed {
            throw TokenStorageServiceError.setAccessTokenFailed
        }
    }

    private func getRefreshToken() throws -> String {
        guard let token = get(refreshTokenKey) else {
            throw TokenStorageServiceError.getRefreshTokenFailed
        }
        return token
    }

    private func setRefreshToken(_ token: String) throws {
        do {
            try set(key: refreshTokenKey, token: token)
        } catch TokenStorageServiceError.setTokenFailed {
            throw TokenStorageServiceError.setRefreshTokenFailed
        }
    }

    private func get(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
            let data = item as? Data,
            let token = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return token
    }

    private func set(key: String, token: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: token.data(using: .utf8)!,
            kSecAttrAccessible as String:
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            throw TokenStorageServiceError.setTokenFailed
        }
    }

    private func remove(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Failed to remove key: \(key)")
            throw TokenStorageServiceError.removeTokenFailed
        }
    }

    deinit {
        print("Deinitialize TokenStorageService")
    }
}
