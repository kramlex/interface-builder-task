//
//  RegisterViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 24.03.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginRegisterTextField: CustomTextField!
    @IBOutlet weak var emailRegisterTextField: CustomTextField!
    @IBOutlet weak var passwordRegisterTextField: CustomTextField!
    
    override func viewDidLoad() {
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
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
    
    deinit {
        unregisterKeyboardNotifications()
    }
}

// MARK: Scroll View Keyboard Handler
extension RegisterViewController : ScrollViewKeyboardDelegate {}

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
