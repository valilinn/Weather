//
//  HourlyTableViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 23/09/2023.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
