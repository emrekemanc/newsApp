//
//  NewsDetailViewModel.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 9.05.2025.
//
import Foundation
class NewsDetailViewModel: ObservableObject{
    @Published var new: Datum?
    @Published var errorMessage: String? = nil
    private let apiService: APIService = APIServiceImpl()
    
    func loadNew(newIndex: Int){
        apiService.fetchNews(query: nil, topic: "WORLD" ,limit: 5, time_published: "anytime", country: "TR", lang: "tr") { result in
            switch result{
            case .success(let news):
                self.new = news[newIndex]
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
