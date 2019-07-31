//
//  SecondScreenCoordinator.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

class SecondScreenCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        start()
    }

    func start() {
        let secondVc = SecondScreenViewController()
        secondVc.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        secondVc.tabBarItem.accessibilityIdentifier = "SecondScreenViewController.tabBarItem"
        navigationController.pushViewController(secondVc, animated: false)
    }

}
