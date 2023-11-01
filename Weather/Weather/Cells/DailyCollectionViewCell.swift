//
//  DailyCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import Foundation
import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    var viewModel: WeatherViewModel?
    
    func setupBinders(_ index: Int) {
        viewModel?.dayOfTheWeek[index].bind { [weak self] day in
            DispatchQueue.main.async { [weak self] in
                self?.dayLabel.text = day ?? ""
            }
        }
    }
    
    func setup() {
        dayLabel.text = "Today"
        maxTempLabel.text = "40 C"
        minTempLabel.text = "20 C"
        imageView.image = UIImage(named: "cloudWithMoon")
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
}

