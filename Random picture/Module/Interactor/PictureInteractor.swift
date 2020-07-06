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
    func savePicture()
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
        apiWorker.fetchPicture(with: dimension, callback: { pictureEntity, error in
            print("I have the picture from intetactor")
            if let pictureEntity = pictureEntity {
                self.pictureEntity = pictureEntity
                self.presenter?.interactor(interactor: self, object: pictureEntity)
            }
        })
    }
    
    func savePicture() {
        if let id = self.pictureEntity?.id {
            apiWorker.fetchPictureInfo(with: id, callback: { pictureInfo, error in
                if let pictureInfo = pictureInfo {
                    let url = pictureInfo.downloadURL
                    self.apiWorker.fetchPictureFullSize(with: url, callback: { pictureEntity,error in
                        // Do stuff to save image to camera roll
                        // Call presenter to indicate status of 
                    })
                }
            })
        }
    }
    
    
}
