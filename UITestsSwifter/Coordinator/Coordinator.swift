//
//  Coordinator.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
