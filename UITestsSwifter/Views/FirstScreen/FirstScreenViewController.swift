//
//  FirstScreenViewController.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit
import SnapKit

protocol FirstScreenViewProtocol: class {
    func updateViewModel(_ viewModel: FirstScreenViewController.ViewModel)
    func updateResultLabelText(_ text: String)
}

class FirstScreenViewController: UIViewController {

    let textField = UITextField()
    let textFieldLine = UIView()
    let searchButton = UIButton()
    let resultLabel = UILabel()

    let bookImageView = UIImageView()
    let bookTitleLabel = UILabel()
    let bookSubtitleLabel = UILabel()
    let bookIsbnLabel = UILabel()
    let bookPriceLabel = UILabel()

    private var presenter = FirstScreenPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSomeViews()
        presenter.attachView(view: self)
    }

    private func setupSomeViews() {
        view.backgroundColor = .white
        title = "Search"

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            } else {
                make.top.equalToSuperview().offset(16)
            }
            make.size.equalTo(24)
            make.trailing.equalToSuperview().offset(-8)
        }
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        searchButton.accessibilityIdentifier = "FirstScreenViewController.searchButton"

        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(searchButton.snp.top)
            make.height.equalTo(24)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
        }
        textField.placeholder = "Search"
        textField.delegate = self
        textField.accessibilityIdentifier = "FirstScreenViewController.textField"

        view.addSubview(textFieldLine)
        textFieldLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(1)
            make.leading.equalTo(textField.snp.leading)
            make.trailing.equalTo(textField.snp.trailing)
        }
        textFieldLine.backgroundColor = .black

        view.addSubview(resultLabel)
        resultLabel.font = UIFont.boldSystemFont(ofSize: 26)
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
            make.top.equalTo(textFieldLine).offset(20)
        }
        resultLabel.accessibilityIdentifier = "FirstScreenViewController.resultLabel"

        view.addSubview(bookImageView)
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(140)
            make.width.equalTo(120)
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
        bookImageView.accessibilityIdentifier = "FirstScreenViewController.bookImageView"

        view.addSubview(bookTitleLabel)
        bookTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(bookImageView.snp.bottom).offset(10)
        }
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        bookTitleLabel.accessibilityIdentifier = "FirstScreenViewController.bookTitleLabel"

        view.addSubview(bookSubtitleLabel)
        bookSubtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(10)
        }
        bookSubtitleLabel.numberOfLines = 0
        bookSubtitleLabel.textAlignment = .left
        bookSubtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        bookSubtitleLabel.accessibilityIdentifier = "FirstScreenViewController.bookSubtitleLabel"

        view.addSubview(bookIsbnLabel)
        bookIsbnLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(bookSubtitleLabel.snp.bottom).offset(10)
        }
        bookIsbnLabel.numberOfLines = 1
        bookIsbnLabel.textAlignment = .left
        bookIsbnLabel.font = UIFont.italicSystemFont(ofSize: 14)
        bookIsbnLabel.accessibilityIdentifier = "FirstScreenViewController.bookIsbnLabel"

        view.addSubview(bookPriceLabel)
        bookPriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(bookIsbnLabel.snp.bottom).offset(10)
        }
        bookPriceLabel.textAlignment = .right
        bookPriceLabel.accessibilityIdentifier = "FirstScreenViewController.bookPriceLabel"

    }

    @objc private func onPress() {
        guard let text = textField.text else {
            return
        }

        textField.resignFirstResponder()
        presenter.searchBook(bookName: text)
    }
    
    private func clearLabels() {
        resultLabel.text = ""
        bookTitleLabel.text = ""
        bookSubtitleLabel.text = ""
        bookIsbnLabel.text = ""
        bookPriceLabel.text = ""
        bookImageView.image = nil
    }
}

extension FirstScreenViewController: FirstScreenViewProtocol {
    func updateViewModel(_ viewModel: FirstScreenViewController.ViewModel) {

        DispatchQueue.main.async {
            self.bookTitleLabel.text = viewModel.bookTitleLabelText
            self.bookSubtitleLabel.text = viewModel.bookSubtitleLabelText
            self.bookIsbnLabel.text = "ISBN - \(viewModel.bookIsbnLabelText)"
            self.bookPriceLabel.text = viewModel.bookPriceLabelText
            self.bookImageView.downloadImage(from: viewModel.bookImageUrl)
        }
    }

    func updateResultLabelText(_ text: String) {
         DispatchQueue.main.async {
            self.resultLabel.text = text
        }
    }
    
}

extension FirstScreenViewController {
    struct ViewModel {
        var bookTitleLabelText = ""
        var bookSubtitleLabelText = ""
        var bookIsbnLabelText = ""
        var bookPriceLabelText = ""
        var bookImageUrl = ""
    }
    
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        clearLabels()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.searchBook(bookName: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
}
