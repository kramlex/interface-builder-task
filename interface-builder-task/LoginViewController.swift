//
//  ViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 15.03.2021.
//

import UIKit

class LoginViewController: KeyboardNotificationViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginAuthTextField: CustomTextField!
    @IBOutlet weak var passwordAuthTextField: CustomTextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var authLabel: UILabel!
    
    // MARK: Variables
    var defaultFontSize: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.changingView = scrollView
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
        defaultFontSize = authLabel.font.pointSize
        scrollView.delegate = self
    }
    
    private func reDelegateTextFields() {
        loginAuthTextField.delegate = self
        passwordAuthTextField.delegate = self
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: multiply = 2
    func resizeLabelFont() {
        let offsetY: CGFloat = scrollView.contentOffset.y
        if (offsetY < 0.0 && offsetY > -150.0) {
            authLabel.font = authLabel.font.withSize(defaultFontSize * (-offsetY / 200.0 + 1.0 ))
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBaseNextTextField(textField)
        return true
    }

    private func switchBaseNextTextField(_ textField: UITextField) {
        switch textField {
        case loginAuthTextField:
            passwordAuthTextField.becomeFirstResponder()
        default:
            passwordAuthTextField.resignFirstResponder()
        }
    }
}

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resizeLabelFont()
    }
}
