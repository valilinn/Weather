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
        viewModel?.hours[index].bind { [weak self] hour in
            DispatchQueue.main.async { [weak self] in
                self?.hourLabel.text = hour ?? ""
            }
        }
        
        viewModel?.imageInHours[index].bind { [weak self] image in
            guard let image = image else { return }
            guard let imageURL = URL(string: "https:\(image)") else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        viewModel?.tempInHours[index].bind { [weak self] temp in
            DispatchQueue.main.async { [weak self] in
                self?.temperatureLabel.text = temp ?? ""
            }
        }
        
    }
    
    func setup() {
//        imageView.image = UIImage(named: "cloudWithMoon")
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
}
