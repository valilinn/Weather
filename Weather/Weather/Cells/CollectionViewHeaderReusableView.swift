//
//  CollectionViewHeaderReusableView.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import UIKit

class CollectionViewHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var nameOfSection: UILabel!
    
    func setup(_ title: String) {
        nameOfSection.text = title
        nameOfSection.textColor = UIColor.white
    }

}
