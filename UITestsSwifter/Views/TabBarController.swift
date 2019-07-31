//
//  TabBarController.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let fsc = FirstScreenCoordinator()
    let ssc = SecondScreenCoordinator()

    let mainCoordinator = AppCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        mainCoordinator.start()
        viewControllers = [fsc.navigationController, ssc.navigationController]
        self.view.backgroundColor = .red
    }
}
