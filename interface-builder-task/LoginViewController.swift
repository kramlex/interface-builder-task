//
//  ViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 15.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginFieldBackgroundView: UIView!
    @IBOutlet weak var passwordFieldBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewProperty(editedView: loginFieldBackgroundView, targetRadius: 8, targetWidth: 1)
        setViewProperty(editedView: passwordFieldBackgroundView, targetRadius: 8, targetWidth: 1)
    }
    
    func setViewProperty(editedView view: UIView, targetRadius radius: CGFloat, targetWidth width: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.borderWidth = width
    }
    
}
