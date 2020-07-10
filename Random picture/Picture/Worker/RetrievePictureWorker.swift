//
//  RetrievePictureWorker.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit
import os.log

protocol RetrievePictureWorkerProtocol {
    func fetchPicture(with dimension: Picture.Dimension, callback:@escaping (Picture.Entity?, String?) -> Void)
    func fetchPictureInfo(with pictureId: Int, callback:@escaping(Picture.Info?, String?) -> Void)
    func fetchPictureFullSize(with url: String, callback:@escaping(Picture.Entity?, String?) -> Void)
}

class RetrievePictureWorker: RetrievePictureWorkerProtocol {
    let networkWorker = NetworkWorker()
    let requestConfiguration = NetworkConfiguration(scheme: "https", host: "picsum.photos", port: 443, param: nil)
    func fetchPictureInfo(with pictureId: Int, callback:@escaping(Picture.Info?, String?) -> Void) {
        let url = networkWorker.makeURL(path: "/id/\(pictureId)/info", configuration: requestConfiguration)
        if let url = url {
            networkWorker.httpRequest(url: url, httpMethod: "GET", body: nil, callback: { data, error, statusCode in
                if statusCode == StatusCode.success {
                    let decoder = JSONDecoder()
                    do {
                        guard let response = data else {
                            callback(nil, "Unknown response : \(error ?? "unknown reason")")
                            return
                        }
                        if let json = String(data: response, encoding: .utf8),
                            let jsonData = json.data(using: .utf8) {
                            callback(try decoder.decode(Picture.Info.self, from: jsonData), nil)
                        }
                    } catch {
                        callback(nil, "Unable to parse data")
                    }
                }
            })
        }
    }
    func fetchPictureFullSize(with url: String, callback:@escaping(Picture.Entity?, String?) -> Void) {
        let imageURL = url.replacingOccurrences(of: "https://picsum.photos", with: "")
        let url = networkWorker.makeURL(path: imageURL, configuration: requestConfiguration)
        if let url = url {
            networkWorker.httpRequest(url: url, httpMethod: "GET", body: nil, callback: { data, error, statusCode in
                if statusCode == StatusCode.success,
                    let data = data,
                    let image = UIImage(data: data) {
                    callback(Picture.Entity(image: image, pictureId: 42, dimension: nil), nil)
                } else {
                    callback(nil, "Unable to get picture \(error ?? "unknown reason")")
                }
            })
        }
    }
    func fetchPicture(with dimension: Picture.Dimension, callback:@escaping(Picture.Entity?, String?) -> Void) {
        let url = networkWorker.makeURL(path: "/\(dimension.width)/\(dimension.height).jpg",
            configuration: requestConfiguration)
        if let url = url {
            networkWorker.httpRequest(url: url, httpMethod: "GET", body: nil, callback: { data, error, statusCode in
                let pictureId = self.networkWorker.headerResponse["picsum-id"]
                if statusCode == StatusCode.success,
                    let data = data,
                    let image = UIImage(data: data),
                    let pictureId = pictureId as? String,
                    let idNum = Int(pictureId) {
                    callback(Picture.Entity(image: image, pictureId: idNum, dimension: dimension), nil)
                } else {
                    callback(nil, "Unable to get picture \(error ?? "unknow reason")")
                }
            })
        }
    }
}
