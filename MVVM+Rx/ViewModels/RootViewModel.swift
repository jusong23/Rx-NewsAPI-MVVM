//
//  RootViewModel.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import Foundation
import RxSwift
import RxCocoa

class RootViewModel {
    let title = "MVVM+Rx"
    
    // RootViewModel에 의존성 주입 (의존하는 객체 articleService가 수정되면 RootViewModel도 영향 받음)
    private let articleService:ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleElement]>{
        articleService.fetchNews()
    }
}
