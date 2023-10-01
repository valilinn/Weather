//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 23/09/2023.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var temperaturePerHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
