//
//  APIModel.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//
import Foundation

// MARK: - APIModel
struct APIModel: Codable {
    let status, requestID: String?
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let title: String
    let link: String
    let snippet: String
    let photoURL: String?
    let thumbnailURL: String?
    let publishedDatetimeUTC: String
    let authors: [String]
    let sourceURL: String
    let sourceName: String
    let sourceLogoURL: String?
    let sourceFaviconURL: String
    let sourcePublicationID: String
    let relatedTopics: [RelatedTopic]

    enum CodingKeys: String, CodingKey {
        case title, link, snippet
        case photoURL = "photo_url"
        case thumbnailURL = "thumbnail_url"
        case publishedDatetimeUTC = "published_datetime_utc"
        case authors
        case sourceURL = "source_url"
        case sourceName = "source_name"
        case sourceLogoURL = "source_logo_url"
        case sourceFaviconURL = "source_favicon_url"
        case sourcePublicationID = "source_publication_id"
        case relatedTopics = "related_topics"
    }
}

// MARK: - RelatedTopic
struct RelatedTopic: Codable {
    let topicID, topicName: String

    enum CodingKeys: String, CodingKey {
        case topicID = "topic_id"
        case topicName = "topic_name"
    }
}
