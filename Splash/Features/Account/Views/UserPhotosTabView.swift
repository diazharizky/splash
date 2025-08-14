//
//  UserPhotosTabView.swift
//  Splash
//
//  Created by Magnifico on 03/08/25.
//

import SwiftUI

struct UserPhotosTabView: View {
    @EnvironmentObject private var userPhotosViewModel: UserPhotosViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("No photos")
            Spacer()
        }
    }
}
