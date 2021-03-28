//
//  TableViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 25.03.2021.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        let greatTableViewCellNib = UINib.init(nibName: "GreatTableViewCell", bundle: Bundle.main)
        tableView.register(greatTableViewCellNib, forCellReuseIdentifier: "GreatTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        default:
            return 20
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: "GreatTableViewCell", for: indexPath) as? GreatTableViewCell {
            cell.imageView?.image = UIImage(systemName: "paperplane.fill")
            return cell
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.iconImageView.image = UIImage(systemName: "square.and.arrow.down")
            cell.titleLabel.text = "\(indexPath.row) in \(indexPath.section)"
            return cell
        }
        return UITableViewCell()
    }
}
