//
//  ViewController.swift
//  Random picture
//
//  Created by Craig Josse on 03/07/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit

protocol PictureViewProtocol: class {
    var presenter: PicturePresenterProtocol? { get set }
    var wireFrame: (NSObjectProtocol & PictureRouterProtocol)? { get set }
    func set(viewModel: PictureViewModel)
    func createAlert(title: String, message: String, actionTitle: String)
}

class ViewController: UIViewController {
    var presenter: PicturePresenterProtocol?
    var wireFrame: (NSObjectProtocol & PictureRouterProtocol)?
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
    @IBAction func nextButton(_ sender: Any) {
        presenter?.fetchNewPicture(with: imageDimension())
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare")
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            print("SELECTOR \(selector)")
            print(wireFrame?.responds(to: selector))
            if let router = wireFrame, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

extension ViewController: PictureViewProtocol {
    func set(viewModel: PictureViewModel) {
        DispatchQueue.main.async {
            self.imageView.image = viewModel.image
            self.imageView.isHidden = false
        }
    }
    func createAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
