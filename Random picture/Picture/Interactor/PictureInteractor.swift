//
//  PictureInteractor.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

protocol PictureInteractorProtocol {
    func fetchNewPicture(with dimension: Dimension)
    func savePicture()
}

protocol PictureDataStore {
  var message: String? { get }
}

class PictureInteractor: NSObject, PictureInteractorProtocol, PictureDataStore {
    var message: String?
    let apiWorker: RetrievePictureWorkerProtocol
    var pictureEntity: PictureEntity?
    var presenter: PicturePresenterProtocol?
    required init(withApiWorker apiWorker: RetrievePictureWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    func fetchNewPicture(with dimension: Dimension) {
        apiWorker.fetchPicture(with: dimension, callback: { pictureEntity, _ in
            if let pictureEntity = pictureEntity {
                self.pictureEntity = pictureEntity
                self.apiWorker.fetchPictureInfo(with: pictureEntity.pictureId, callback: { pictureInfo, _ in
                    if let pictureInfo = pictureInfo {
                        self.message = pictureInfo.author
                        self.pictureEntity?.author = pictureInfo.author
                        self.pictureEntity?.downloadURLFullSize = pictureInfo.downloadURL
                        self.presenter?.interactor(interactor: self, object: pictureEntity)
                    }
                })
            }
        })
    }
    func savePicture() {
        if let pictureEntity = pictureEntity,
            let downloadUrl = pictureEntity.downloadURLFullSize {
            self.apiWorker.fetchPictureFullSize(with: downloadUrl, callback: { pictureEntity, _ in
                if let image = pictureEntity {
                    UIImageWriteToSavedPhotosAlbum(
                        image.image, self,
                        #selector(self.image(_:didFinishSavingWithError:contextInfo:)),
                        nil)
                }
            })
        } else {
            self.presenter?.saveResult(interactor: self, statusCode: StatusCode.error)
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            self.presenter?.saveResult(interactor: self, statusCode: StatusCode.error)
        } else {
            self.presenter?.saveResult(interactor: self, statusCode: StatusCode.success)
        }
    }
}
