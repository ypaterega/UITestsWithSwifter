//
//  FirstScreenPresenter.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation

class FirstScreenPresenter {
    weak private var view: FirstScreenViewProtocol?
    
    init(){}
    
    func attachView(view: FirstScreenViewProtocol){
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func searchBook(bookName: String) {
        HttpNetwork.shared.makeRequest(request: .search(book: bookName), params: [:]) { (result: Result<NewReleasesResponseModel, HttpNetwork.HttpError>) in
            switch result {
            case let .success(response):
                self.updateView(response: response)
            case .failure(_):
                break
            }
        }
    }
    
    func updateView(response: NewReleasesResponseModel) {
        var model = FirstScreenViewController.ViewModel()
        
        guard let book = response.books.first, !response.books.isEmpty else {
            view?.updateResultLabelText("Can't find books. Try again")
            return
        }
        
        model.bookSubtitleLabelText = book.subtitle
        model.bookTitleLabelText = book.title
        model.bookPriceLabelText = book.price
        model.bookIsbnLabelText = book.isbn13
        model.bookImageUrl = book.image
        
        self.view?.updateResultLabelText("Search result")
        self.view?.updateViewModel(model)
    }
    
}
