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
        apiService.fetchNews(query: query, limit: 15, time_published: "anytime", country: "TR", lang: "tr") { result in
            switch result{
            case .success(let datum):
                print(datum)
                self.news = datum
            case .failure(let error):
                print(error)
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
