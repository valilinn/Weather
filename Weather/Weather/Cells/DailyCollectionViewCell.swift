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
        viewModel?.minTempOfTheDay[index].bind { [weak self] temp in
            DispatchQueue.main.async { [weak self] in
                self?.minTempLabel.text = temp ?? ""
            }
        }
        viewModel?.maxTempOfTheDay[index].bind { [weak self] temp in
            DispatchQueue.main.async { [weak self] in
                self?.maxTempLabel.text = temp ?? ""
            }
        }
        viewModel?.imageOfTheDay[index].bind { [weak self] image in
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

