//
//  HourlyInfoCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import Foundation
import UIKit

class HourlyInfoCollectionViewCell: UICollectionViewCell {    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var roundedView: UIView!
    
    func setup() {
        hourLabel.text = "12:00"
        temperatureLabel.text = "30 C"
        imageView.image = UIImage(named: "cloudWithMoon")
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
}
