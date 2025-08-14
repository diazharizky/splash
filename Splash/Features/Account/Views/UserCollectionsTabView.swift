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

    var body: some View {
        VStack {
            Spacer()
            Text("No collections")
            Spacer()
        }
    }
}
