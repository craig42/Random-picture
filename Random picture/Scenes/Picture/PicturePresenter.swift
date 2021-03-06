//
//  PicturePresenter.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

protocol PicturePresenterProtocol: class {
    func fetchNewPicture(with dimension: Picture.Dimension)
    func savePicture()
    func interactor(interactor: PictureInteractorProtocol, object: Picture.Entity)
    func saveResult(interactor: PictureInteractorProtocol, statusCode: StatusCode)
}

struct PictureViewModel {
    let image: UIImage
}

class PicturePresenter {
    var view: PictureViewProtocol?
    var interactor: PictureInteractorProtocol?
}

extension PicturePresenter: PicturePresenterProtocol {
    func interactor(interactor: PictureInteractorProtocol, object: Picture.Entity) {
        let pictureViewModel = PictureViewModel(image: object.image)
        view?.set(viewModel: pictureViewModel)
    }
    func saveResult(interactor: PictureInteractorProtocol, statusCode: StatusCode) {
        #if targetEnvironment(macCatalyst)
            view?.createAlert(title: "Error", message: "Cannot save picture on macOS platform", actionTitle: "Ok")
        #else
            switch statusCode {
            case StatusCode.success:
                view?.createAlert(title: "Success", message: "Message saved into library", actionTitle: "Ok")
            case StatusCode.error:
                view?.createAlert(title: "Fail",
                              message: "There is an error, check your library permission", actionTitle: "Ok")
            default:
                break
        }
        #endif
    }
    func fetchNewPicture(with dimension: Picture.Dimension) {
        interactor?.fetchNewPicture(with: dimension)
    }
    func savePicture() {
        interactor?.savePicture()
    }
}
