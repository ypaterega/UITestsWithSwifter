//
//  CustomTableViewCell.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 29/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let isbnLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(4)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 0
        
        addSubview(isbnLabel)
        isbnLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        isbnLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        isbnLabel.numberOfLines = 0
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(isbnLabel.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .right
    }
}

extension CustomTableViewCell {
    func updateCell(viewModel: CustomTableViewCell.ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        isbnLabel.text = "ISBN - \(viewModel.isbn)"
        priceLabel.text = viewModel.price
    }
}

extension CustomTableViewCell {
    struct ViewModel {
        var title: String = ""
        var subtitle: String = ""
        var isbn: String = ""
        var price: String = ""
    }
}
