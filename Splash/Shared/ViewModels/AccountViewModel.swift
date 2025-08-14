//
//  AccountViewModel.swift
//  Splash
//
//  Created by Magnifico on 29/07/25.
//

import AuthenticationServices

enum AccountViewModelError: Error {
    case authCodeNotFound
}

@MainActor
protocol AccountViewModelProtocol {
    var isLoggedIn: Bool { get }
    func login(callbackURL: URL) async throws
    func logout()
    func loadAccount() async throws
    func increaseLikesCount()
    func decreaseLikesCount()
}

@MainActor
final class AccountViewModel: AccountViewModelProtocol, ObservableObject {
    private let authService: AuthServiceProtocol
    private let accountService: AccountServiceProtocol

    @Published var isLoggedIn: Bool
    @Published var account: AccountModel?

    init(
        authService: AuthServiceProtocol,
        accountService: AccountServiceProtocol
    ) {
        self.authService = authService
        self.accountService = accountService
        self.isLoggedIn = authService.isLoggedIn
        print("Initialize AccountViewModel")
    }

    private func resolveAuthCode(from callbackURL: URL) throws -> String {
        let components = URLComponents(
            url: callbackURL,
            resolvingAgainstBaseURL: false
        )
        guard let components = components?.queryItems else {
            throw URLError(.badURL)
        }

        guard let code = components.first(where: { $0.name == "code" })?.value
        else {
            throw AccountViewModelError.authCodeNotFound
        }
        return code
    }

    func login(callbackURL: URL) async throws {
        let code = try resolveAuthCode(from: callbackURL)
        try await authService.requestToken(authCode: code)
        isLoggedIn = authService.isLoggedIn
        try await loadAccount()
    }

    func logout() {
        do {
            try authService.logout()
            isLoggedIn = authService.isLoggedIn
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }

    func loadAccount() async throws {
        if !self.isLoggedIn {
            return
        }

        let loggedAccount = try await accountService.getLoggedAccount()
        self.account = AccountModel(
            username: loggedAccount.username ?? "",
            name: loggedAccount.name ?? "",
            email: "web.diazharizky@gmail.com",
            totalLikes: loggedAccount.total_likes ?? 0,
            totalPhotos: loggedAccount.total_photos ?? 0,
            totalCollections: loggedAccount.total_collections ?? 0,
            bio: loggedAccount.bio
        )
    }

    func increaseLikesCount() {
        account?.increaseTotalLikes()
    }

    func decreaseLikesCount() {
        account?.decreaseTotalLikes()
    }

    deinit {
        print("Deinitialize AccountViewModel")
    }
}
