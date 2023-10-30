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
    
    var viewModel: WeatherViewModel?
    
    func setupBinders() {
        viewModel?.cityName.bind { [weak self] cityName in
            self?.cityLabel.text = cityName
        }
        viewModel?.currentTemperature.bind { [weak self] temp in
            self?.temperatureLabel.text = temp
        }
        
    }
    
}
