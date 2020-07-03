//
//  PictureEntity.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

struct PictureEntity {
    let image : UIImage
    let id : Int
    let dimension : Dimension
}

struct Dimension {
    var height: Double
    var width: Double
}
