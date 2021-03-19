//
//  CustomButton.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 19.03.2021.
//

import UIKit

@IBDesignable
class CustomButtom: UIButton {
    
    var hlColor = #colorLiteral(red: 0.1921568627, green: 0.4078431373, blue: 1, alpha: 1)
    var defaultColor = #colorLiteral(red: 0.1921568627, green: 0.4078431373, blue: 0.9568627451, alpha: 1)
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViewProperty(targetColor: defaultColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewProperty(targetColor: defaultColor)
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? hlColor : defaultColor
        }
    }
    
    func setViewProperty(targetColor color: UIColor) {
        backgroundColor = color
    }
}
