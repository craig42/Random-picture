//
//  NetworkWorker.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import os.log

class NetworkWorker {
    var headerResponse = [AnyHashable: Any]()
    func makeURL(path: String, configuration: NetworkConfiguration) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = configuration.scheme
        urlComponents.host = configuration.host
        urlComponents.port = configuration.port
        urlComponents.path = path
        if let dict = configuration.param {
            urlComponents.queryItems = []
            for (name, value) in dict {
                urlComponents.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        return urlComponents.url
    }
    func httpRequest(url: URL, httpMethod: String, body: String?,
                     callback : @escaping (Data?, String?, StatusCode) -> Void ) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
        if let body = body {
            request.httpBody = body.data(using: .utf8)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {  // check for networking error
                if let error = error {
                    os_log("Error : %@", type: .error, "\(error)" )
                    callback(nil, "error=\(error)", StatusCode.error)
                }
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                os_log("StatusCode is : %@", type: .info, "\(httpStatus.statusCode)")
                self.headerResponse = httpStatus.allHeaderFields
                os_log("Request : %@", type: .debug, "\(request)" )
                if httpStatus.statusCode == 200 {
                    callback(data, nil, StatusCode.success)
                } else {
                    callback(nil, "Server error", StatusCode.error)
                }
            }
        }
        task.resume()
    }
    func httpDataToText(data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}
