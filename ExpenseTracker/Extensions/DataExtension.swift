//
//  DataExtension.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 05/01/2022.
//

import Foundation

extension Date {
    func formattedDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
}
