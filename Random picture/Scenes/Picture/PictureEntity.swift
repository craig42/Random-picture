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
    struct Info: Codable {
        let id, author: String
        let width, height: Int
        let url, downloadURL: String

        enum CodingKeys: String, CodingKey {
            case id, author, width, height, url
            case downloadURL = "download_url"
        }
    }
}
