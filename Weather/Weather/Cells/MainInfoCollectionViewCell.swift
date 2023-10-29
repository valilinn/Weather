//
//  MainInfoCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 28/10/2023.
//

import Foundation
import UIKit

class MainInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func setup() {
        cityLabel.text = "Katowice"
        temperatureLabel.text = "30 C"
        infoLabel.text = "Partly cloudy"
    }
    
}
