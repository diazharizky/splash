//
//  UserCollectionsTabView.swift
//  Splash
//
//  Created by Magnifico on 03/08/25.
//

import SwiftUI

struct UserCollectionsTabView: View {
    @EnvironmentObject private var userCollectionsViewModel:
        UserCollectionsViewModel
    @EnvironmentObject private var languageManager: LanguageManager

    var body: some View {
        VStack {
            Spacer()
            Text(
                languageManager.tr("UserCollectionsTabView.text.no_collections")
            )
            Spacer()
        }
    }
}
