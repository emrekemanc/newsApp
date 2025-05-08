//
//  DateFormatterHelper.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//

import Foundation

struct DateFormatterHelper{
    static func formatted(dateString: String) -> String{
        let formatted = ISO8601DateFormatter()
        if let date = formatted.date(from: dateString){
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return "-"
    }
}
