//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 12/09/2023.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func registerCells() {
        let hourlyCellNib = UINib(nibName: "HourlyTableViewCell", bundle: Bundle.main)
        tableView.register(hourlyCellNib, forCellReuseIdentifier: "hourlyTableViewCell")
        
    }
    
    private func setupTable() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
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
            return "Current weather"
        } else if section == 1 {
            return "3-days weather forecast"
        }
        return nil
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyTableViewCell", for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}
