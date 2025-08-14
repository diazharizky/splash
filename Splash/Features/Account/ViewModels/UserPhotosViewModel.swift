//
//  UserPhotosViewModel.swift
//  Splash
//
//  Created by Magnifico on 12/08/25.
//

import Foundation

protocol UserPhotosViewModelProtocol {

}

final class UserPhotosViewModel: UserPhotosViewModelProtocol, ObservableObject {
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        print("Initialize UserPhotosViewModel")
    }

    deinit {
        print("Deinitialize UserPhotosViewModel")
    }
}
