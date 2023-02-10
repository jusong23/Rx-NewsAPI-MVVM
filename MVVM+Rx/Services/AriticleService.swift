//
//  AriticleService.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import Foundation
import RxSwift
import RxCocoa

public class SimpleError: Error {
    public init() { }
}

// 확장성을 위해 프로토콜 생성
protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

// fetch class
class ArticleService: ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> { // 🔩 model struct name
        return Observable.create { (emitter) in
            let newsUrl = "https://newsapi.org/v2/everything?q=tesla&from=2023-01-10&sortBy=publishedAt&apiKey=ec15f841011f4f9a82c7dee79a0289fc" // 🔩 url

            // [1st] URL instance 작성
            guard let url = URL(string: newsUrl) else {
                emitter.onError(SimpleError())
                return Disposables.create()
            }

            // [2nd] Task 작성(.resume)
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                // error: 에러처리
                if let error = error { return }
                // response: 서버 응답 정보
                guard let httpResponse = response as? HTTPURLResponse else { return }
                guard (200 ... 299).contains(httpResponse.statusCode) else { return }

                // data: 서버가 읽을 수 있는 Binary 데이터
                guard let data = data else { fatalError("Invalid Data") }

                do {
                    let decoder = JSONDecoder()
                    let articleResponse = try decoder.decode(ArticleResponse.self, from: data) // 🔩 model struct name
                    
                    emitter.onNext(articleResponse.articles)
                    emitter.onCompleted()
                } catch {
                    emitter.onError(SimpleError())
                    print(error)
                }
            }
            task.resume() // suspend 상태의 task 깨우기

            return Disposables.create()
        }
    }
}

// 더미데이터 입력하여 서버에서 가져온 거 처럼 테스트가 가능
class dummyArticleService: ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (emitter) -> Disposable in
            
//            // dummy data 1
//            ArticleElement(source: Source(id: "dummy", name: "dummy"), author: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy", content: "dummy")
//            // dummy data 2
//            ArticleElement(source: Source(id: "dummy", name: "dummy"), author: "dummy", title: "dummy", description: "dummy", url: "dummy", urlToImage: "dummy", publishedAt: "dummy", content: "dummy")
            
            return Disposables.create()
        }
    }
}
