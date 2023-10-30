//
//  HourlyInfoCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import UIKit

class HourlyInfoCollectionViewCell: UICollectionViewCell {    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    var viewModel: WeatherViewModel?
    
    func setupBinders(_ index: Int) {
//        print("my hours - \(viewModel?.hours[3].value)")
//        viewModel?.hours[index].bind { [weak self] hour in
//            DispatchQueue.main.async { [weak self] in
//                self?.hourLabel.text = hour ?? ""
//                self?.viewModel?.completionHandler?()
//            }
//        }
    }
    
    func setup() {
       
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
}
