//
//  StringExtensions.swift
//  Splash
//
//  Created by Magnifico on 17/08/25.
//

import Foundation

extension String {
    func localized(using languageCode: String) -> String {
        guard
            let path = Bundle.main.path(
                forResource: languageCode,
                ofType: "strings"
            ), let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}
