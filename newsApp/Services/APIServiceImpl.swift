//
//  APIServiceImpl.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import Foundation
class APIServiceImpl: APIService{
    private let session = URLSession.shared
    
    func fetchNews(query: String?, limit: Int = 5, time_published: String = "anytime", country: String = "TR", lang: String = "tr",completion: @escaping(Result<[Datum], Error>) -> Void){
        var components = URLComponents(string: "https://real-time-news-data.p.rapidapi.com/topic-headlines")
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "time_published", value: time_published),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "lang", value: lang)
        ]
        if let query = query, !query.isEmpty{
            components = URLComponents(string: "https://real-time-news-data.p.rapidapi.com/search")
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        components?.queryItems = queryItems
        guard let url = components?.url else {return completion(.failure(NSError(domain: "bad_url", code: -1)))}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secrets.shared.apiHost, forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue(Secrets.shared.apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        session.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
            }
            guard let data = data else{ completion(.failure(NSError(domain: "no_data", code: -1))); return}
            do{
                let decoded = try JSONDecoder().decode(APIModel.self, from: data)
                completion(.success(decoded.data))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
}
