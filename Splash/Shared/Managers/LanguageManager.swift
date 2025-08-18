//
//  LanguageManager.swift
//  Splash
//
//  Created by Magnifico on 17/08/25.
//

import SwiftUI

enum LanguageSelection: String, CaseIterable {
    case en = "English"
    case id = "Bahasa Indonesia"
}

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    @AppStorage("appLanguage") var selectedLanguage = LanguageSelection.en {
        didSet { objectWillChange.send() }
    }

    private func bundleForLanguage(_ lang: LanguageSelection) -> Bundle? {
        guard
            let path = Bundle.main.path(forResource: "\(lang)", ofType: "lproj")
        else { return nil }
        return Bundle(path: path)
    }

    func tr(_ key: String) -> String {
        let lang = selectedLanguage
        let bundle = bundleForLanguage(lang) ?? .main
        return NSLocalizedString(
            key,
            tableName: nil,
            bundle: bundle,
            value: key,
            comment: ""
        )
    }
}
