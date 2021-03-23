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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
    }
    
    private func reDelegateTextFields() {
        loginRegisterTextField.delegate = self
        passwordRegisterTextField.delegate = self
        emailRegisterTextField.delegate = self
    }
    
    @objc func keyboardWillShow(sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            var inset = scrollView.contentInset
            inset.bottom = keyboardHeight - view.safeAreaInsets.bottom
            scrollView.contentInset = inset
        }
    }
    
    @objc func keyboardWillHide(sender: Notification) {
        scrollView.contentInset = .zero
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
