//
//  RegisterViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 24.03.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginRegisterTextField: CustomTextField!
    @IBOutlet weak var emailRegisterTextField: CustomTextField!
    @IBOutlet weak var passwordRegisterTextField: CustomTextField!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: Variables
    var defaultFontSize: CGFloat = 0.0
    
    @IBOutlet weak var registrationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
        defaultFontSize =  registrationLabel.font.pointSize
        scrollView.delegate = self
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
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset + view.safeAreaInsets.bottom
            let yPosition = -view.safeAreaInsets.bottom
            let scrollPoint = CGPoint(x: 0, y: yPosition)
            scrollView.setContentOffset(scrollPoint, animated: false)
        }
    }
    
    @objc func keyboardWillBeHidden(_ sender: Notification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        scrollView.contentOffset.y = 0.0
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

extension RegisterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resizeLabelFont()
    }
}
