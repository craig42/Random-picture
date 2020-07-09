//
//  PicturePresenter.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

protocol PicturePresenterProtocol: class {
    func fetchNewPicture(with dimension: Dimension)
    func savePicture()
    func interactor(interactor: PictureInteractorProtocol, object: PictureEntity)
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
    func interactor(interactor: PictureInteractorProtocol, object: PictureEntity) {
        let pictureViewModel = PictureViewModel(image: object.image)
        print("I'm setting to the view : \(pictureViewModel.image)")
        view?.set(viewModel: pictureViewModel)
    }
    func saveResult(interactor: PictureInteractorProtocol, statusCode: StatusCode) {
        switch statusCode {
        case StatusCode.success:
            view?.createAlert(title: "Success", message: "Message saved into library", actionTitle: "Ok")
        case StatusCode.error:
            view?.createAlert(title: "Fail",
                              message: "There is an error, check your library permission", actionTitle: "Ok")
        default:
            break
        }
    }
    func fetchNewPicture(with dimension: Dimension) {
        print("fetch picture from presenter")
        interactor?.fetchNewPicture(with: dimension)
    }
    func savePicture() {
        print("save picture from presenter")
        interactor?.savePicture()
    }
}
