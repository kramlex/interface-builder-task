//
//  KeyboardNotificationViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 26.03.2021.
//

import UIKit

class KeyboardNotificationViewController: UIViewController {
    
    weak var changingView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillBeShown(_ sender: Notification) {
        guard let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return }
        settingShowValuesInScrollView(keyboardSize: keyboardSize)
    }
    
    @objc func keyboardWillBeHidden(_ sender: Notification) {
        settingHideValuesInScrollView()
        
    }
    
    func settingShowValuesInScrollView(keyboardSize: CGRect) {
        guard let changingView = changingView else { return }
        let bottomInset = keyboardSize.height
        changingView.contentInset.bottom = bottomInset
        changingView.verticalScrollIndicatorInsets.bottom = bottomInset + view.safeAreaInsets.bottom
        let yPosition = -view.safeAreaInsets.bottom
        let scrollPoint = CGPoint(x: 0, y: yPosition)
        changingView.setContentOffset(scrollPoint, animated: false)
    }
    
    func settingHideValuesInScrollView() {
        guard let changingView = changingView else { return }
        changingView.contentInset = .zero
        changingView.verticalScrollIndicatorInsets = .zero
        changingView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
//        changingView.contentOffset.y = 0.0
    }
    
    deinit {
        unregisterKeyboardNotifications()
    }
    
    
}
