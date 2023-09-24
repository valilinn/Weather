//
//  SettingsViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var settings: Settings!
    
    var settingCellsCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func registerCell() {
        let settingsCellNib = UINib(nibName: "SettingsTableViewCell", bundle: Bundle.main)
        tableView.register(settingsCellNib, forCellReuseIdentifier: "settingsTableViewCell")
    }
    
    private func setupTableView() {
        registerCell()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "UNITS"
    }
    //change header text color
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.text = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.white
        headerLabel.frame = CGRect(x: 15, y: 5, width: tableView.frame.size.width - 30, height: 30)
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         switch indexPath.row {
         case 0:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
             cell.setupUnitButton(index: indexPath.row)
             return cell
         case 1:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
             cell.setupUnitButton(index: indexPath.row)
             return cell
         case 2:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
             cell.setupUnitButton(index: indexPath.row)
             return cell
         case 3:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
             cell.setupUnitButton(index: indexPath.row)
             return cell
         case 4:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
             cell.setupUnitButton(index: indexPath.row)
             return cell
         default:
             return UITableViewCell()
         }
         
    }

}
