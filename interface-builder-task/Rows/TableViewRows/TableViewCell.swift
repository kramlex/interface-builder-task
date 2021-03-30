//
//  TableViewCell.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 25.03.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = .green
        } else {
            contentView.backgroundColor = .white
        }
    }
}
