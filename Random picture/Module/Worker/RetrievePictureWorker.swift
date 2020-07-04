//
//  RetrievePictureWorker.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

protocol RetrievePictureWorkerProtocol {
    func fetchPicture(with dimension: Dimension, callback:@escaping (PictureEntity) -> Void)
}

class RetrievePictureWorker : RetrievePictureWorkerProtocol {
    let networkWorker = NetworkWorker()
    func prepareURL(_ dimension:Dimension) -> URL? {
        let requestConfiguration = NetworkConfiguration(scheme: "https", host: "picsum.photos", port: 443, param: nil)
        
        return  networkWorker.makeURL(path: "/\(dimension.width)/\(dimension.height).jpg", configuration: requestConfiguration)
    }
    
    func fetchPicture(with dimension: Dimension, callback:@escaping(PictureEntity) -> Void) {
        let url = prepareURL(dimension)
        if let url = url {
            networkWorker.httpRequest(url: url, httpMethod: "GET", body: nil, callback: { data, error, statusCode in
                let id = self.networkWorker.headerResponse["picsum-id"]
                print("retrieve data and status code is \(id)")
                if statusCode == StatusCode.success,
                    let data = data,
                    let image = UIImage(data: data),
                    let id = id as? String,
                    let idNum = Int(id) {
                    print("now callbacking")
                    callback(PictureEntity (image: image, id: idNum, dimension: dimension))
                }
            })
        }
    }
}

