//
//  DateFormatter+convertToCurrentLocalizedText.swift
//  Diary
//
//  Created by Mangdi, junho on 2022/12/22.
//

import Foundation

extension DateFormatter {
    static func convertToCurrentLocalizedText(timeIntervalSince1970: Double) -> String {
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
}