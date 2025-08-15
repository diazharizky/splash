//
//  UserPhotosTabView.swift
//  Splash
//
//  Created by Magnifico on 03/08/25.
//

import SwiftUI

struct UserPhotosTabView: View {
    @EnvironmentObject private var userPhotosViewModel: UserPhotosViewModel
    @Binding var isLoading: Bool

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                Task {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isLoading = true
                    }
                    try? await Task.sleep(for: .seconds(3))
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isLoading = false
                    }
                }
            }) {
                Text("Simulate Loading")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.top, 2)
            Spacer()
        }
    }
}

#Preview {
    let userPhotosViewModel = UserPhotosViewModel(
        authService: AuthService.shared
    )
    UserPhotosTabView(isLoading: .constant(false))
        .environmentObject(userPhotosViewModel)
}
