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
        
        hourlyCollectionView.backgroundColor = UIColor.clear
        
        let oneHourNib = UINib(nibName: "HourlyCollectionViewCell", bundle: Bundle.main)
        hourlyCollectionView.register(oneHourNib, forCellWithReuseIdentifier: "hourlyCollectionViewCell")
        
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        
        setupScroll()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupScroll() {
        if let flowLayout = hourlyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // padding to zero
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        
        guard let cell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCollectionViewCell", for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 90
        let cellHeight = 90
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
