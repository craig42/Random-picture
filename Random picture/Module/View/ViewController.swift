//
//  ViewController.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

protocol PictureViewProtocol : class {
    var presenter: PicturePresenterProtocol? { get set }
    func set(viewModel: PictureViewModel)
}

class ViewController: UIViewController {
    var presenter: PicturePresenterProtocol?
    
    @IBOutlet var imageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchNewPicture(with: imageDimension())
    }
    
    func imageDimension() -> Dimension {
        return Dimension(height: Int(Double(imageView.frame.height)), width: Int(Double(imageView.frame.width)))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @IBAction func saveImageButton(_ sender: Any) {
        presenter?.savePicture()
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        presenter?.aboutView()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        presenter?.fetchNewPicture(with: imageDimension())
    }
      
}

extension ViewController: PictureViewProtocol {
    func set(viewModel: PictureViewModel) {
        DispatchQueue.main.async {
            self.imageView.image = viewModel.image
            self.imageView.isHidden = false
        }
    }
}
