//
//  HttpStubService.swift
//  UITestsSwifterUITests
//
//  Created by Iurii Paterega on 26/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation
import Swifter

enum HTTPMethod {
    case GET
    case POST
}

class HttpStubService {
    var server = HttpServer()
    
    func setUp() {
        setupStubs()
        try! server.start()
    }
    
    func tearDown() {
        server.stop()
    }
    
    private func setupStubs() {
        for stub in initialStubs {
            setupStub(url: stub.url, filename: stub.jsonFilename, method: stub.method)
        }
    }
    
    public func setupStub(url: String, filename: String, method: HTTPMethod = .GET) {

        if let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .uncached)
                let json = try JSONSerialization.jsonObject(with: data)

                let response: ((HttpRequest) -> HttpResponse) = { _ in
                    return HttpResponse.ok(.json(json as AnyObject))
                }

                switch  method {
                case .GET:
                    server.GET[url] = response
                case .POST:
                    server.POST[url] = response
                }
            } catch {
                print("There is error. Something gone wrong")
            }
        }

    }
}

struct HTTPStub {
    let url: String
    let jsonFilename: String
    let method: HTTPMethod
}

let initialStubs = [
    HTTPStub(url: "/new", jsonFilename: "new", method: .GET)
]
