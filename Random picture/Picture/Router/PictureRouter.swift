//
//  PictureRouterProtocol.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

@objc protocol PictureRouterProtocol {
    func routeToDetails(segue: UIStoryboardSegue)
}

protocol PictureDataPassing {
    var dataStore: PictureDataStore? { get }
}

class PictureRouter: NSObject, PictureRouterProtocol {
    weak var viewController: ViewController?
    var dataStore: PictureDataStore?
    func routeToDetails(segue: UIStoryboardSegue) {
        let pictureDS = dataStore
        let detailsVC = segue.destination as? DetailsViewController
        let detailsDS = detailsVC?.router?.dataStore
        if let pictureDS = pictureDS,
            var detailsDS = detailsDS {
            passDataToDetail(source: pictureDS, destination: &(detailsDS))
        }
    }
    private func passDataToDetail(source: PictureDataStore, destination: inout DetailsDataStore) {
        destination.message = source.message
    }
}
