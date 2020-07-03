//
//  NetworkConfiguration.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
    let scheme : String
    let host : String
    let port : Int
    let param : [String:String]?
    static let slash = "/"
}

enum StatusCode: Int {
    case success = 0, error, notUpdated, locationProblem, alreadyUpdated, connectionProblem
}

