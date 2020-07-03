//
//  PicturePresenter.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

protocol PicturePresenterProtocol: class {
    
    func fetchNewPicture(with Dimension: Dimension)
    
    func savePicture()
    
    func aboutView()
    
    func interactor(interactor: PictureInteractorProtocol, object: PictureEntity)
    
}

struct PictureViewModel {
    let image: UIImage
}


class PicturePresenter {
    var view: PictureViewProtocol?
    var interactor: PictureInteractorProtocol?
    var wireFrame: PictureRouterProtocol?
}

extension PicturePresenter: PicturePresenterProtocol {
    
    func interactor(interactor: PictureInteractorProtocol, object: PictureEntity) {
        let pictureViewModel = PictureViewModel(image: object.image)
        view?.set(viewModel: pictureViewModel)
    }
    
    
    func fetchNewPicture(with dimension: Dimension) {
        print("fetch picture from presenter")
        interactor?.fetchNewPicture(with: dimension)
    }
    
    func savePicture() {
        
    }
    
    func aboutView() {
        
    }
}
