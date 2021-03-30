//
//  UICollectionViewCell+NibName.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 29.03.2021.
//

import UIKit

extension UICollectionViewCell {
    static func nibName() -> String {
        String(describing: Self.self)
    }
}
