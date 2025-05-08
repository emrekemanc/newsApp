//
//  APIService.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//

import Foundation
protocol APIService {
    func fetchNews(query: String?, limit: Int, time_published: String, country: String, lang: String,
        completion: @escaping (Result<[Datum], Error>) -> Void
    )
}


