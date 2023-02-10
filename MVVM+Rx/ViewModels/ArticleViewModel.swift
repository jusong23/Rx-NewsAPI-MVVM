//
//  ArticleViewModel.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import Foundation

struct ArticleViewModel { 
    private let article: Article

    var urlToImage: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
