//
//  HttpNetwork.swift
//  UITestsSwifter
//
//  Created by Iurii Paterega on 29/07/2019.
//  Copyright © 2019 Iurii Paterega. All rights reserved.
//

import Foundation

class HttpNetwork {
    static let shared = HttpNetwork()
    let decoder = JSONDecoder()
    var dataTask: URLSessionDataTask?

    enum HttpError: Error {
        case emptyData
        case decodingError(error: Error)
        case networkError(error: Error)
    }

    enum Request {
        case new
        case search(book: String)

        func path() -> String {
            switch self {
            case .new:
                return "new"
            case let .search(book):
                return "search/\(book)"
            }
        }
    }

    func getBaseURL() -> String {
        #if TEST
            return "http://localhost:8080"
        #else
            return "https://api.itbook.store/1.0/"
        #endif
    }

    func makeRequest<T: Codable>(request: Request,
                                 params: [String: Any]?,
                                 completionHandler:  @escaping ((Result<T,HttpError>) -> ())) {

        let baseURL = URL(string: getBaseURL())!
        let url = baseURL.appendingPathComponent(request.path())
        let session = URLSession.shared

        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data else {
                completionHandler(.failure(.emptyData))
                return
            }

            guard  error == nil else  {
                completionHandler(.failure(.networkError(error: error!)))
                return
            }

            do {
                let object = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(object))
            } catch {
                completionHandler(.failure(.decodingError(error: error)))
            }
        })

        dataTask?.resume()
    }

    func stopTask() {
        dataTask?.cancel()
    }
}
