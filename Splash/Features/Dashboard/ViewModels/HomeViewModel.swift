//
//  HomeViewModel.swift
//  Splash
//
//  Created by Magnifico on 28/07/25.
//

import Foundation

protocol HomeViewModelProtocol {

}

@MainActor
final class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    init() {
        print("Initialize HomeViewModel")
    }

    deinit {
        print("Deinitialize HomeViewModel")
    }
}
