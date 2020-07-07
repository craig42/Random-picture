//
//  PictureBuilder.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import Foundation
import UIKit

class PictureBuilder {
    class func buildModule(view: PictureViewProtocol) -> PictureViewProtocol {
        let presenter = PicturePresenter()
        let interactor = PictureInteractor(withApiWorker: RetrievePictureWorker())
        let router = PictureRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
