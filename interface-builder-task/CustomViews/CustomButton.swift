//
//  CustomButton.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 19.03.2021.
//

import UIKit

@IBDesignable
class CustomButtom: UIButton {
    
    var highlightedColor = #colorLiteral(red: 0.1921568627, green: 0.4078431373, blue: 1, alpha: 1)
    var defaultBackgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4078431373, blue: 0.9568627451, alpha: 1)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViewBackgroundColor(targetColor: defaultBackgroundColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewBackgroundColor(targetColor: defaultBackgroundColor)
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : defaultBackgroundColor
        }
    }
    
    func setViewBackgroundColor(targetColor color: UIColor) {
        backgroundColor = color
    }
}
