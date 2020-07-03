//
//  PictureInteractor.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

protocol PictureInteractorProtocol {
    func fetchNewPicture()
    func savePicture(withId:Int)
}

class PictureInteractor: PictureInteractorProtocol {
    let apiWorker : RetrievePictureWorkerProtocol
    var pictureEntity:PictureEntity?
    
    required init(withApiWorker apiWorker:RetrievePictureWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    
    func fetchNewPicture() {
        let dimension = Dimension(height: 400.0, width: 300.0)
        apiWorker.fetchPicture(with: dimension, callback: { (pictureEntity) in
            self.pictureEntity = pictureEntity
        })
    }
    
    func savePicture(withId:Int) {
        
    }
    
    
}
