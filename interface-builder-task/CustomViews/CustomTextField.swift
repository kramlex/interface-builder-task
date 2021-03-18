//
//  CustomTextField.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 19.03.2021.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
    var bgColor = CGColor(red: 196, green: 196, blue: 196, alpha: 255)
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            layoutIfNeeded()
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViewProperty()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewProperty()
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    func setViewProperty() {
        self.layer.backgroundColor = bgColor
    }
}
