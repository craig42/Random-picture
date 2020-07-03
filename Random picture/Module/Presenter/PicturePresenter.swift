//
//  PicturePresenter.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

protocol PicturePresenterProtocol {
    
    func fetchNewPicture(withDimension:Dimension)
    
    func savePicture()
    
    func aboutView()
    
}

struct PictureViewModel {
    let image: UIImage
}


class PicturePresenter : PicturePresenterProtocol {
    func fetchNewPicture(withDimension:Dimension) {
        
    }
    
    func savePicture() {
        
    }
    
    func aboutView() {
        
    }
    
}
