//
//  EditProfileView.swift
//  Splash
//
//  Created by Magnifico on 03/08/25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject private var accountViewModel: AccountViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var username: String
    @State private var name: String
    @State private var email: String
    @State private var bio: String

    init(account: AccountModel) {
        self.username = account.username
        self.name = account.name
        self.email = account.email
        self.bio = account.bio ?? ""
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Profile") {
                    TextField("Username", text: $username)
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                }

                Section("About") {
                    TextField("Bio", text: $bio)
                }
            }
        }
        .navigationTitle("Edit Profile")
    }
}
