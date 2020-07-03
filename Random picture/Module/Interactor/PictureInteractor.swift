//
//  PictureInteractor.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation

protocol PictureInteractorProtocol {
    func fetchNewPicture(with dimension: Dimension)
    func savePicture(withId:Int)
}

class PictureInteractor: PictureInteractorProtocol {
    let apiWorker : RetrievePictureWorkerProtocol
    var pictureEntity:PictureEntity?
    
    var presenter: PicturePresenterProtocol?
    
    required init(withApiWorker apiWorker:RetrievePictureWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    
    func fetchNewPicture(with dimension: Dimension) {
        print("fetch picture form interactor")
        apiWorker.fetchPicture(with: dimension, callback: { (pictureEntity) in
            print("I have the picture from intetactor")
            self.pictureEntity = pictureEntity
            self.presenter?.interactor(interactor: self, object: pictureEntity)
        })
    }
    
    func savePicture(withId:Int) {
        
    }
    
    
}
