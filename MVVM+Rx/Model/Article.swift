//
//  Article.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import Foundation

// MARK: - ArticleResponse
struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
