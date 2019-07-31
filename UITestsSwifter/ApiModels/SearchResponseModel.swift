//
//  SearchResponseModel.swift
//  NetworkLayer
//
//  Created by Yuriy Paterega on 6/2/19.
//  Copyright © 2019 Yuriy Paterega. All rights reserved.
//

import Foundation

class SearchResponseModel: Codable {
    var error: String
    var total: String
    var page: String
    var books: [BookResponseModel]
}
