//
//  PictureRouterProtocol.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

protocol PictureRouterProtocol {
    func routeToDetail(segue: UIStoryboardSegue)
}

protocol PictureDataPassing {
  var dataStore: PictureDataStore? { get }
}

class PictureRouter: NSObject, PictureRouterProtocol {
    weak var viewController: ViewController?


    func routeToDetail(segue: UIStoryboardSegue) {
        let detailVC = segue.destination as? DetailsViewController
        //let detailDS = detailVC.router?.dataStore

        //passDataToDetail(source: homeDS, destination: &detailDS)
            
        }
    }

