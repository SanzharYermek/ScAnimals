//
//  TabBarViewController.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let viewControllers = makeItems()
//        for viewController in viewControllers {
//            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 9.0, left: 0.0, bottom: -9.0, right: 0.0)
//        }

        tabBar.isTranslucent = false
        tabBar.barTintColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.6431372549, green: 0.8549019608, blue: 0.3921568627, alpha: 1)
        tabBar.unselectedItemTintColor = .white
        self.viewControllers = makeItems()


    }
}

private extension TabBarViewController {

    func makeItems() -> [UINavigationController] {

        let scanner = ScannerViewController().inNavigate()
        scanner.tabBarItem = UITabBarItem.init(title: "Главный", image: #imageLiteral(resourceName: "ion_scan-sharp"), tag: 0)

        let search = SearchByCategoryViewController().inNavigate()
        search.tabBarItem = UITabBarItem.init(title: "Категория", image: #imageLiteral(resourceName: "search"), tag: 1)

        let saved = SavedViewController().inNavigate()
        saved.tabBarItem = UITabBarItem.init(title: "Сохраненные", image: #imageLiteral(resourceName: "Vector"), tag: 2)

        let history = HistoryViewController().inNavigate()
        history.tabBarItem = UITabBarItem.init(title: "История", image: #imageLiteral(resourceName: "history"), tag: 3)

        return [scanner, search, saved, history]
    }
}
