//
//  RootViewController.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import UIKit
import SnapKit
import RxSwift

class RootViewController: UIViewController {

    
    // MARK: Property
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    // 의존성 주입 (RootViewController <- RootViewModel)

    // MARK: LifeCycle
    // RootViewModel에 의해 단방향 전달 받음(= 의존하는 것)
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchArticles()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
    }

    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articles in
            print(articles)
        }).disposed(by: disposeBag)
    }

}
