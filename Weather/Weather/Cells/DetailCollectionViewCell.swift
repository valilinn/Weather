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
    
    func setup() {
        contentName.text = "Wind"
        contentValue.text = "2 m/s"
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
    
}
