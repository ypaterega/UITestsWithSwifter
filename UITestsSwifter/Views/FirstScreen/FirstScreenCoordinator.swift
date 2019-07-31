//
//  FirstScreenCoordinator.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

class FirstScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        start()
    }

    func start() {
        let firstVc = FirstScreenViewController()
        firstVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        firstVc.tabBarItem.accessibilityIdentifier = "FirstScreenViewController.tabBarItem"
        navigationController.pushViewController(firstVc, animated: false)
    }

}
