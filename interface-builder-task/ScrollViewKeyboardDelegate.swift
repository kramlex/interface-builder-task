//
//  ScrollViewKeyboardDelegate.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 24.03.2021.
//

import UIKit

protocol ScrollViewKeyboardDelegate: class {
    var scrollView: UIScrollView! { get set }
    func registerKeyboardNotifications()
    func unregisterKeyboardNotifications()
}

extension ScrollViewKeyboardDelegate where Self: UIViewController {
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillBeShown(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillBeHidden(notification)
        }
    }

    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    func keyboardWillBeShown(_ notification: Notification) {
        let info = notification.userInfo
        let key = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)
        let oKeyboardSize = key?.cgRectValue

        guard let keyboardSize = oKeyboardSize,
            let scrollView = self.scrollView else {
                return
        }

        let bottomInset = keyboardSize.height
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        if let activeField = self.view.firstResponder {
            let yPosition = activeField.frame.origin.y - bottomInset
            if yPosition > 0 {
                let scrollPoint = CGPoint(x: 0, y: yPosition)
                scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }

    func keyboardWillBeHidden(_ notification: Notification) {
        self.scrollView?.contentInset = .zero
        self.scrollView?.scrollIndicatorInsets = .zero
    }
}

extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else {
            return self
        }
        
        return subviews.first {
            $0.firstResponder != nil
        }
    }
}

