//
//  ViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 15.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginAuthTextField: CustomTextField!
    @IBOutlet weak var passwordAuthTextField: CustomTextField!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(detectAnimationDuration(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillBeShown(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomInset = keyboardSize.height
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset + view.frame.origin.y - view.safeAreaInsets.bottom
            let yPosition = -view.safeAreaInsets.bottom
            let scrollPoint = CGPoint(x: 0, y: yPosition)
            scrollView.setContentOffset(scrollPoint, animated: false)
            
        }
    }
    
    @objc func keyboardWillBeHidden(_ sender: Notification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func detectAnimationDuration(_ sender: Notification) {
        print("Keyboard did hide")
//        print("Content size : \(scrollView.contentSize)")
//        print("View size: \(view.frame.size)")
        if let keyboardAnimationDuration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] {
            print("Keyboard animation duration: \(keyboardAnimationDuration) sec")
        }
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
