//
//  RegisterViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 24.03.2021.
//

import UIKit

class RegisterViewController: KeyboardNotificationViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginRegisterTextField: CustomTextField!
    @IBOutlet weak var emailRegisterTextField: CustomTextField!
    @IBOutlet weak var passwordRegisterTextField: CustomTextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var registrationLabel: UILabel!
    
    // MARK: Variables
    var defaultFontSize: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.changingView = scrollView
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
        defaultFontSize =  registrationLabel.font.pointSize
        scrollView.delegate = self
    }
    
    private func reDelegateTextFields() {
        loginRegisterTextField.delegate = self
        passwordRegisterTextField.delegate = self
        emailRegisterTextField.delegate = self
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    func resizeLabelFont() {
        let offsetY: CGFloat = scrollView.contentOffset.y
        if (offsetY < 0.0 && offsetY > -150.0) {
            registrationLabel.font = registrationLabel.font.withSize(defaultFontSize * (-offsetY / 200.0 + 1.0 ))
        }
        if (offsetY < -150.0) {
            scrollView.contentOffset.y = -150.0
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBaseNextTextField(textField)
        return true
    }
    
    private func switchBaseNextTextField(_ textField: UITextField) {
        switch textField {
        case loginRegisterTextField:
            emailRegisterTextField.becomeFirstResponder()
        case emailRegisterTextField:
            passwordRegisterTextField.becomeFirstResponder()
        default:
            passwordRegisterTextField.resignFirstResponder()
        }
    }
}

extension RegisterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resizeLabelFont()
    }
}
