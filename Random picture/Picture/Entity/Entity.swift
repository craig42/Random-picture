//
//  PictureEntity.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit


enum Picture {
    struct Entity {
        let image: UIImage
        let pictureId: Int
        let dimension: Dimension?
        var author: String?
        var downloadURLFullSize: String?
    }
    
    struct Dimension {
        var height: Int
        var width: Int
    }
}



