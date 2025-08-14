//
//  AccountTabView.swift
//  Splash
//
//  Created by Magnifico on 29/07/25.
//

import AuthenticationServices
import SwiftUI

struct AccountTabView: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel

    @Environment(\.webAuthenticationSession) private
        var webAuthenticationSession

    private let oAuthURL: String =
        "https://unsplash.com/oauth/authorize?client_id=YQXwh1kLcPk2rv4eljqgoFgLQfKznvTO9e9RM20h7aw&redirect_uri=splash://account-auth&response_type=code&scope=public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections"

    var body: some View {
        NavigationStack {
            VStack {
                if accountViewModel.isLoggedIn {
                    AccountDetailView()
                } else {
                    Button(action: {
                        Task {
                            do {
                                guard
                                    let oAuthURL = URL(
                                        string: self.oAuthURL
                                    )
                                else {
                                    print("Invalid oAuth URL")
                                    return
                                }

                                let url =
                                    try await webAuthenticationSession
                                    .authenticate(
                                        using: oAuthURL,
                                        callbackURLScheme: "splash",
                                        preferredBrowserSession: .ephemeral
                                    )
                                try await accountViewModel.login(
                                    callbackURL: url
                                )
                            } catch {
                                print(
                                    "Unable to login: \(error.localizedDescription)"
                                )
                            }
                        }
                    }) {
                        Text("Sign in")
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onDisappear {
            print("Destroying AccountTabView")
        }
    }
}

#Preview {
    AccountTabView()
}
