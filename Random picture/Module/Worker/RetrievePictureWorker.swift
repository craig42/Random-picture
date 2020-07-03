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
        let pictureURL = "https://picsum.photos/"
        
        let requestConfiguration = NetworkConfiguration(scheme: "http", host: pictureURL, port: 80, param: nil)
        
        return  networkWorker.makeURL(path: "/\(dimension.width)/\(dimension.height)", configuration: requestConfiguration)
    }
    
    func fetchPicture(with dimension: Dimension, callback:@escaping(PictureEntity) -> Void) {
        let url = prepareURL(dimension)
        if let url = url {
            networkWorker.httpRequest(url: url, httpMethod: "GET", body: nil, callback: { data, error, statusCode in
                
                if statusCode == StatusCode.success,
                    let data = data,
                    let image = UIImage(data: data),
                    let id = self.networkWorker.headerResponse["Picsum-Id"] as? Int {
                    callback(PictureEntity (image: image, id: id, dimension: dimension))
                }
            })
        }
    }
}

