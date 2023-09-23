//
//  WeatherDetailsCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 23/09/2023.
//

import UIKit

class WeatherDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roundedView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
        
    
    }

}
