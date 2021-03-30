//
//  GreatTableViewCell.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 25.03.2021.
//

import UIKit

class GreatTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = .green
        } else {
            contentView.backgroundColor = .white
        }
    }
    
}
