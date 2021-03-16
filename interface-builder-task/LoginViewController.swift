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
    
    func setViewProperty(view v : UIView, radius r: CGFloat, width w: CGFloat) {
        v.layer.cornerRadius = r
        v.layer.borderWidth = w
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewProperty(view: loginFieldBackgroundView, radius: 8, width: 1)
        setViewProperty(view: passwordFieldBackgroundView, radius: 8, width: 1)
        
    }
    
}

