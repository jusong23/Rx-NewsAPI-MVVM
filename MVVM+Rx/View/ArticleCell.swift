//
//  ArticleCell.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/10.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UITableViewCell {
    // MARK: Properties
    let disposeBag = DisposeBag()
    var viewModel = PublishSubject<ArticleViewModel>()
    // RootVC에서의 이벤트를 이곳에 방출시켜줄 것이기에 Subject
    var newsImageView = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()

    // MARK: Helpers
    func subcribe() {
        print(#function)
        self.viewModel.subscribe(onNext: { articleViewModel in
            print(articleViewModel)
            if let urlString = articleViewModel.urlToImage {
                self.newsImageView.sd_setImage(with: URL(string: urlString), completed: nil)
            }

            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
        }).disposed(by: disposeBag)
    }

    // MARK: Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subcribe()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)

        [newsImageView, titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }

        backgroundColor = .systemBackground

        newsImageView.layer.cornerRadius = 8
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.backgroundColor = .systemBackground

        titleLabel.font = .boldSystemFont(ofSize: 20)

        descriptionLabel.numberOfLines = 3

        newsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.top)
            make.leading.equalTo(newsImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
}

