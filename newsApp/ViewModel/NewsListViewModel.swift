//
//  Untitled.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import Foundation
class NewsListViewModel: ObservableObject{
    @Published var news: [Datum] = []
    @Published var errorMessage: String? = nil
    private let apiService: APIService = APIServiceImpl()
    func loadNews(query: String?){
        apiService.fetchNews(query: query, topic: "WORLD", limit: 15, time_published: "anytime", country: "TR", lang: "tr") { result in
            switch result{
            case .success(let datum):
                self.news = datum
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
