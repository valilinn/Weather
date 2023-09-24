//
//  SettingsTableViewCell.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var unitSelectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setupUnitButton(settingType: Settings, state: UIMenuElement.State) {
    
    func setupUnitButton(index: Int) {
        
        let selectedUnit = {(action: UIAction) in
            print(action.title)}
        
        unitSelectionButton.showsMenuAsPrimaryAction = true
        unitSelectionButton.changesSelectionAsPrimaryAction = true
        
        switch index {
        case 0:
            unitLabel.text = "Temperature"
            unitSelectionButton.menu = UIMenu(children: [
                UIAction(title: "°C", state: .on, handler: selectedUnit),
                UIAction(title: "°F", state: .off, handler: selectedUnit)
            ])
            
        case 1:
            unitLabel.text = "Wind"
            unitSelectionButton.menu = UIMenu(children: [
                UIAction(title: "mph", state: .on, handler: selectedUnit),
                UIAction(title: "km/h", state: .off, handler: selectedUnit),
                UIAction(title: "m/s", state: .off, handler: selectedUnit)
            ])
            
        case 2:
            unitLabel.text = "Pressure"
            unitSelectionButton.menu = UIMenu(children: [
                UIAction(title: "mbar", state: .on, handler: selectedUnit),
                UIAction(title: "inHg", state: .off, handler: selectedUnit)
            ])
            
        case 3:
            unitLabel.text = "Precipitation"
            unitSelectionButton.menu = UIMenu(children: [
                UIAction(title: "mm", state: .on, handler: selectedUnit),
                UIAction(title: "in", state: .off, handler: selectedUnit)
            ])
            
        case 4:
            unitLabel.text = "Visibility"
            unitSelectionButton.menu = UIMenu(children: [
                UIAction(title: "km", state: .on, handler: selectedUnit),
                UIAction(title: "miles", state: .off, handler: selectedUnit)
            ])
            
        default:
            return
        }
        
        
        
    }
    
    
}
