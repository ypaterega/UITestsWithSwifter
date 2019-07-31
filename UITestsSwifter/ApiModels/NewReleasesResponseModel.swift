//
//  NewReleasesResponseModel.swift
//  NetworkLayer
//
//  Created by Yuriy Paterega on 6/2/19.
//  Copyright © 2019 Yuriy Paterega. All rights reserved.
//

import Foundation

class NewReleasesResponseModel: Codable {
    var error: String
    var total: String
    var books: [BookResponseModel]
}
