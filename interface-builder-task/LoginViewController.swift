//
//  ViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 15.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginAuthTextField: CustomTextField!
    @IBOutlet weak var passwordAuthTextField: CustomTextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var authLabel: UILabel!
    
    // MARK: Variables
    var defaultFontSize: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        reDelegateTextFields()
        defaultFontSize = authLabel.font.pointSize
        scrollView.delegate = self
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(detectAnimationDuration(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
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
        scrollView.contentOffset.y = 0.0
    }
    
    // MARK: detect Animation Time
    @objc func detectAnimationDuration(_ sender: Notification) {
        print("Keyboard did hide")
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
    
    
    // MARK: multiply = 2
    func resizeLabelFont() {
        let offsetY: CGFloat = scrollView.contentOffset.y
        if (offsetY < 0.0 && offsetY > -150.0) {
            authLabel.font = authLabel.font.withSize(defaultFontSize * (-offsetY / 200.0 + 1.0 ))
        }
    }
    
    deinit {
        unregisterKeyboardNotifications()
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
