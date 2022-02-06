//
//  DateFormatterExtension.swift
//  CalendarSwiftUI
//
//  Created by ProstoKakTo on 06.02.2022.
//

import Foundation

extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}
