//
//  ViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 15.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: CustomTextField!
    @IBOutlet weak var passTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.reDelegateTextFields()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBaseNextTextField(textField)
        return true
    }
    
    private func reDelegateTextFields() {
        loginTextField.delegate = self
        passTextField.delegate = self
    }
    
    private func switchBaseNextTextField(_ textField: UITextField) {
        switch textField {
        case self.loginTextField:
            self.passTextField.becomeFirstResponder()
        case self.passTextField:
            passTextField.resignFirstResponder()
        default:
            self.passTextField.resignFirstResponder()
        }
    }
}

extension LoginViewController {
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Keyboard Handling for using ScrollView
extension LoginViewController {
    // code
}
