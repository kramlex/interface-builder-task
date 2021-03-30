//
//  ColletionViewController.swift
//  interface-builder-task
//
//  Created by Марк Дубков on 29.03.2021.
//

import UIKit

class ColletionViewController: UIViewController {

    @IBOutlet weak var colletionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CollectionViewCell.nibName(), bundle: nil)
        colletionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.nibName())
        
        colletionView.dataSource = self
        colletionView.delegate = self
    }
}

extension ColletionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        150
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.nibName(), for: indexPath) as? CollectionViewCell
        
        guard let collectionViewCell = cell else {
            return UICollectionViewCell()
        }
        
        collectionViewCell.cellImage.image = UIImage(systemName: "square.and.arrow.down")
        collectionViewCell.cellLabel.text = " \(indexPath.row) from \(indexPath.section)"
        
        return collectionViewCell
    }
}

extension ColletionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenBounds = UIScreen.main.bounds
        let sideSize = screenBounds.
        return CGSize(width: screenBounds.width / 2.0 , height: screenBounds.height / 10.0)
    }
}
