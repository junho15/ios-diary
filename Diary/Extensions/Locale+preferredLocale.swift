//
//  Locale+preferredLocale.swift
//  Diary
//
//  Created by junho lee on 2022/12/21.
//

import Foundation

extension Locale {
    static var preferredLocale: Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
