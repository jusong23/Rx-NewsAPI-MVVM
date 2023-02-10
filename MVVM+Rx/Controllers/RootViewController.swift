//
//  RootViewController.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()
    // RootViewModel에 대한 ViewModel
    let viewModel: RootViewModel // 의존성 주입 - RootViewModel에게 의존하게 만듬
    let tableView = UITableView()
    let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelModelObeservable: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }

    // MARK: LifeCycles
    init(viewModel: RootViewModel) { // RootViewModel에 의해 단방향 전달 받음(= 의존하는 것)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120

        configureUI()
        configureTableView()
        fetchArticles()
        subscribe()
    }

    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = self.viewModel.title

        tableView.backgroundColor = .systemGray

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func configureTableView() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    }

    // MARK: Helpers
    func fetchArticles() {
        viewModel.fetchArticles()
//            .subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global()))
            .subscribe(onNext: { articleViewModels in
//                print(articleViewModels)
            self.articleViewModel.accept(articleViewModels)
            // ✅ onNext와 같은 의미 (이벤트를 받아 구독자에게 방출)
        }).disposed(by: disposeBag)
    }

    // MARK: Subject 대신 Relay의 장점을 여기서 활용
    // 한번 구독하면 onNext만 해도 방출할 수 있다. (Subject는 계속 구독해줘야함)
    func subscribe() {
        self.articleViewModelModelObeservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { articles in // View로 전달
                print(#function)
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        // articleViewModelModelObeservable을 통해 옵저버블로 변경되므로 onNext가능
        
        return cell
    }
}
