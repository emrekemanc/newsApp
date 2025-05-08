//
//  Secrets.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import Foundation
import Foundation

struct Secrets: Decodable {
    let apiKey: String
    let apiHost: String

    enum CodingKeys: String, CodingKey {
        case apiKey = "API_KEY"
        case apiHost = "API_HOST"
    }

    static let shared: Secrets = {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            fatalError("Secrets.plist bulunamadı.")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try PropertyListDecoder().decode(Secrets.self, from: data)
            return decoded
        } catch {
            fatalError("Secrets.plist decode edilemedi: \(error)")
        }
    }()
}
