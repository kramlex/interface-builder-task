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
        super.viewDidLoad()
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillBeShown(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomInset = keyboardSize.height
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset + view.frame.origin.y - view.safeAreaInsets.bottom
            let yPosition = view.frame.origin.x - bottomInset
            if yPosition > 0 {
                let scrollPoint = CGPoint(x: 0, y: yPosition)
                scrollView.setContentOffset(scrollPoint, animated: false)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(_ sender: Notification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
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
