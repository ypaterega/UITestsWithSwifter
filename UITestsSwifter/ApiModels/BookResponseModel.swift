//
//  BookResponseModel.swift
//  NetworkLayer
//
//  Created by Yuriy Paterega on 6/2/19.
//  Copyright © 2019 Yuriy Paterega. All rights reserved.
//

import Foundation

class BookResponseModel: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String
}
