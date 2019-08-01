//
//  SecondScreenPresenter.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation

class SecondScreenPresenter {

    weak private var view: SecondScreenViewProtocol?

    init(){}

    func attachView(view: SecondScreenViewProtocol){
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func getData() {
        HttpNetwork.shared.makeRequest(request: .new, params: [:])
        { (result: Result<NewReleasesResponseModel, HttpNetwork.HttpError>) in
            switch result {
            case let .success(response):
                self.updateView(response: response)
            case .failure(_):
                break
            }
        }
    }

   private func updateView(response: NewReleasesResponseModel) {
        var model = SecondScreenViewController.ViewModel()

        response.books.forEach { book in
            var cellViewModel = CustomTableViewCell.ViewModel()
            cellViewModel.title = book.title
            cellViewModel.subtitle = book.subtitle
            cellViewModel.isbn = book.isbn13
            cellViewModel.price = book.price

            model.cells.append(cellViewModel)
        }
        self.view?.updateViewModel(model)
    }
    
}
