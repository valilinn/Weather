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
    
    var settings: Settings?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    func setupUnitButton(index: Int, settings: Settings?) {
        
        
                
        unitSelectionButton.showsMenuAsPrimaryAction = true
        unitSelectionButton.changesSelectionAsPrimaryAction = true
        
        switch index {
        case 0:
            unitLabel.text = "Temperature"
            unitSelectionButton.menu = UIMenu(children: [
                self.createUnitAction(title: TemperatureType.celsius.rawValue, isSelected: self.settings?.temperature == .celsius) { action in
                    self.settings?.temperature = .celsius
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: TemperatureType.fahrenheit.rawValue, isSelected: self.settings?.temperature == .fahrenheit) { action in
                    self.settings?.temperature = .fahrenheit
                    self.settings?.saveToUserDefaults()
                    print(action)
                }
            ])
            
        case 1:
            unitLabel.text = "Wind"
            unitSelectionButton.menu = UIMenu(children: [
                self.createUnitAction(title: WindVelocityType.mph.rawValue, isSelected: self.settings?.windVelocity == .mph) { action in
                    self.settings?.windVelocity = .mph
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: WindVelocityType.kph.rawValue, isSelected: self.settings?.windVelocity == .kph) { action in
                    self.settings?.windVelocity = .kph
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: WindVelocityType.mps.rawValue, isSelected: self.settings?.windVelocity == .mps) { action in
                    self.settings?.windVelocity = .mps
                    self.settings?.saveToUserDefaults()
                    print(action)
                }
            ])
            
        case 2:
            unitLabel.text = "Pressure"
            unitSelectionButton.menu = UIMenu(children: [
                self.createUnitAction(title: PressureType.mbar.rawValue, isSelected: self.settings?.pressure == .mbar) { action in
                    self.settings?.pressure = .mbar
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: PressureType.inches.rawValue, isSelected: self.settings?.pressure == .inches) { action in
                    self.settings?.pressure = .inches
                    self.settings?.saveToUserDefaults()
                    print(action)
                }
            ])
            
        case 3:
            unitLabel.text = "Precipitation"
            unitSelectionButton.menu = UIMenu(children: [
                self.createUnitAction(title: PrecipitationType.mm.rawValue, isSelected: self.settings?.precipitation == .mm) { action in
                    self.settings?.precipitation = .mm
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: PrecipitationType.inches.rawValue, isSelected: self.settings?.precipitation == .inches) { action in
                    self.settings?.precipitation = .inches
                    self.settings?.saveToUserDefaults()
                    print(action)
                }
            ])
            
        case 4:
            unitLabel.text = "Visibility"
            unitSelectionButton.menu = UIMenu(children: [
                self.createUnitAction(title: SpaceType.km.rawValue, isSelected: self.settings?.space == .km) { action in
                    self.settings?.space = .km
                    self.settings?.saveToUserDefaults()
                    print(action)
                },
                self.createUnitAction(title: SpaceType.miles.rawValue, isSelected: self.settings?.space == .miles) { action in
                    self.settings?.space = .miles
                    self.settings?.saveToUserDefaults()
                    print(action)
                }
            ])
            
        default:
            return
        }
        
        
    }
    
    private func createUnitAction(title: String, isSelected: Bool, handler: @escaping UIActionHandler) -> UIAction {
        return UIAction(title: title, state: isSelected ? .on : .off, handler: handler)
    }
    
    
}
