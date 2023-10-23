//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 12/09/2023.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    
    var viewModel = WeatherViewModel()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    let sizeOfHourlyCell: CGFloat = 120
    let sizeOfForecastCell: CGFloat = 80
    
    var numbersOfRows: CGFloat = 2
    var cellSpacing: CGFloat = 5
    
    private let settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        setupTableAndCollectionView()
        configureRefreshControl()
    }
    
    func setupBinders() {
        viewModel.cityName.bind { [weak self] cityName in
            self?.cityLabel.text = cityName
        }
        viewModel.currentTemperature.bind { [weak self] temp in
            self?.currentTemperatureLabel.text = temp
        }
        viewModel.updateWeatherValues()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SettingsViewController {
            destinationVC.settings = settings
        }
    }
    
    
    private func registerCells() {
        let hourlyCellNib = UINib(nibName: "HourlyTableViewCell", bundle: Bundle.main)
        tableView.register(hourlyCellNib, forCellReuseIdentifier: "hourlyTableViewCell")
        
        let forecastCellNib = UINib(nibName: "ForecastTableViewCell", bundle: Bundle.main)
        tableView.register(forecastCellNib, forCellReuseIdentifier: "forecastTableViewCell")
        
        let parametersCellNib = UINib(nibName: "WeatherDetailsCollectionViewCell", bundle: Bundle.main)
        collectionView.register(parametersCellNib, forCellWithReuseIdentifier: "weatherDetailsCollectionViewCell")
        
    }
    
    private func setupTableAndCollectionView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        viewModel.updateWeatherValues()
    }
    
    func updateValues() {
        viewModel.updateWeatherValues()
    }
    
    func configureRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = UIColor.white
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    func handleRefreshControl() {
        updateValues()
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
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

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDetailsCollectionViewCell", for: indexPath) as? WeatherDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 45.0
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}


