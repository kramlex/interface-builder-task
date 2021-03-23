//
//  CustomTextField.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 19.03.2021.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 10.0, left: 12.0, bottom: 10.0, right: 5.0)
    var bgColor = CGColor(red: 196.0, green: 196.0, blue: 196.0, alpha: 255.0)
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViewBackgroundColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewBackgroundColor()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let editingRect = super.editingRect(forBounds: bounds)
        return editingRect.inset(by: textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.textRect(forBounds: bounds)
        return textRect.inset(by: textPadding)
    }
    
    func setViewBackgroundColor() {
        layer.backgroundColor = bgColor
    }
}
