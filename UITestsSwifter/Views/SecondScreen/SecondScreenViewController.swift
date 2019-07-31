//
//  SeconScreenViewController.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

protocol SecondScreenViewProtocol: class {
    func updateViewModel(_ viewModel: SecondScreenViewController.ViewModel)
}

extension SecondScreenViewController {
    struct ViewModel {
        var cells: [CustomTableViewCell.ViewModel] = []
    }
}

class SecondScreenViewController: UIViewController {
    
    private var presenter = SecondScreenPresenter()
    
    let tableView = UITableView()
    let delegate = CustomTableViewDelegate()
    let dataSource = CustomTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.attachView(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataSource.items = []
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .yellow
        title = "New books"
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.accessibilityIdentifier = "SecondScreenCoordinator.tableView"
    }
    
}

extension SecondScreenViewController: SecondScreenViewProtocol {
    func updateViewModel(_ viewModel: SecondScreenViewController.ViewModel) {
        dataSource.items = viewModel.cells
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

