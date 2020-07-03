//
//  ViewController.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

protocol PictureViewProtocol {
    var presenter: PicturePresenterProtocol? { get set }
    func set(viewModel: PictureViewModel)
}

class ViewController: UIViewController, PictureViewProtocol {
    var presenter: PicturePresenterProtocol?
    
    @IBOutlet var imageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchNewPicture(withDimension: imageDimension())
        
    }
    
    func imageDimension() -> Dimension {
        return Dimension(height: Double(imageView.frame.height), width: Double(imageView.frame.width))
    }
    
    @IBAction func saveImageButton(_ sender: Any) {
        presenter?.savePicture()
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        presenter?.aboutView()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        presenter?.fetchNewPicture(withDimension: imageDimension())
    }

    func set(viewModel: PictureViewModel) {
        imageView.image = viewModel.image
    }
      
}

