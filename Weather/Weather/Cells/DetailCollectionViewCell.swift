//
//  DetailCollectionViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import Foundation
import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var contentName: UILabel!
    @IBOutlet weak var contentValue: UILabel!
    
    var viewModel: WeatherViewModel?
    
    func setupBinders(_ index: Int) {
        viewModel?.detailedInfo[index].bind { [weak self] info in
            DispatchQueue.main.async { [weak self] in
                self?.contentValue.text = info ?? ""
            }
        }
        contentName.text = viewModel?.detailedNames[index]
    }
    
    func setup() {
        contentValue.text = "2 m/s"
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
    
}
