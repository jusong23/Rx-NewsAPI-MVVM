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

    // RootViewModel에 의존성 주입 = 누군가에게(API Protocol) 의존하게 만듬
    // (의존하는 객체 articleService가 수정되면 RootViewModel도 영향 받음)
    private let articleService: ArticleServiceProtocol

    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }

    func fetchArticles() -> Observable<[ArticleViewModel]> { // ✅ 배열 내 일부만 추출
        articleService.fetchNews().map { $0.map {
            ArticleViewModel(article: $0)
        }}
    }
}
