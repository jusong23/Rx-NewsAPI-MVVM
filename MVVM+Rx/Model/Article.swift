//
//  Article.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleElement]
}

// MARK: - ArticleElement
struct ArticleElement: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
