//
//  Secrets.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import Foundation

enum Secrets {
    static var apiKey: String {
        return getValue(for: "API_KEY")
    }

    static var apiHost: String {
        return getValue(for: "API_HOST")
    }

    private static func getValue(for key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let value = dict[key] as? String
        else {
            fatalError("'\(key)' bulunamadı. Secrets.plist doğru yapılandırılmamış.")
        }
        return value
    }
}
