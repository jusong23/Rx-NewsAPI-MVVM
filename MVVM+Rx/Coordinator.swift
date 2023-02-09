//
//  Coordinator.swift
//  MVVM+Rx
//
//  Created by mobile on 2023/02/09.
//

import UIKit

class Coordinator {
    let window:UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
