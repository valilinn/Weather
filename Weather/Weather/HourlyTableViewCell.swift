//
//  HourlyTableViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 23/09/2023.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
        
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         return UICollectionViewCell()
    }
    
    
    
}
