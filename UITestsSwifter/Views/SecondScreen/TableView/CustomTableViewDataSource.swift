//
//  CustomTableViewDataSource.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 29/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

class CustomTableViewDataSource: NSObject, UITableViewDataSource {

    var items = [CustomTableViewCell.ViewModel]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Couldn't deque cell with identifier")
        }

        cell.updateCell(viewModel: items[indexPath.row])
        cell.accessibilityIdentifier = "CustomTableViewCell_\(indexPath.row)"

        return cell
    }

}
