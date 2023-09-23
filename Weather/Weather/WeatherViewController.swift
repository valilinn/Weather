//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 12/09/2023.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sizeOfHourlyCell: CGFloat = 120
    let sizeOfForecastCell: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func registerCells() {
        let hourlyCellNib = UINib(nibName: "HourlyTableViewCell", bundle: Bundle.main)
        tableView.register(hourlyCellNib, forCellReuseIdentifier: "hourlyTableViewCell")
        
        let forecastCellNib = UINib(nibName: "ForecastTableViewCell", bundle: Bundle.main)
        tableView.register(forecastCellNib, forCellReuseIdentifier: "forecastTableViewCell")
        
    }
    
    private func setupTable() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }
    
    
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Next 24-hours"
        } else if section == 1 {
            return "3-days weather forecast"
        }
        return nil
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
         if indexPath.section == 0 {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyTableViewCell", for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
             return cell
         } else {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "forecastTableViewCell", for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
             return cell
         }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return sizeOfHourlyCell
        } else {
            return sizeOfForecastCell
        }
    }
    
}
