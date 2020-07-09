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
        let homeDS = dataStore
        let detailVC = segue.destination as? DetailsViewController
        var detailDS = detailVC?.router?.dataStore
        print("dataStore : \(homeDS)")
        print("detailDS : \(detailDS)")
        passDataToDetail(source: homeDS!, destination: &(detailDS)!)
    }
    private func passDataToDetail(source: PictureDataStore, destination: inout DetailsDataStore) {
        destination.message = source.message
    }
}
