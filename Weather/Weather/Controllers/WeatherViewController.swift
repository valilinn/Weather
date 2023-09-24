//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лінчук on 12/09/2023.
//

import UIKit
import Alamofire

enum WeatherRequestPath: String {
    case currentWeather = "/current.json"
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sizeOfHourlyCell: CGFloat = 120
    let sizeOfForecastCell: CGFloat = 80
    
    var numbersOfRows: CGFloat = 2
    var cellSpacing: CGFloat = 5
    
    private let baseUlr = "weatherapi-com.p.rapidapi.com"
    private let apiKey = "1513a718cdmsh8029cf744888920p14a113jsn282b8a4b7b33"
    var currentCity = "Tychy"
    
    private let settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableAndCollectionView()
        makeCurrentWeatherRequest()
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
    
    func makeCurrentWeatherRequest() {
        let urlComponents = makeUrlComponents(for: .currentWeather, place: currentCity)
        let headers: HTTPHeaders = HTTPHeaders([
            "X-RapidAPI-Key" : self.apiKey,
            "X-RapidAPI-Host" : self.baseUlr
        ])
        
        AF.request(urlComponents, headers: headers).response { response in
            guard response.error == nil else {
                print("Request error")
                return
            }
            
            guard let data = response.data else {
                print("Request error")
                return
            }
            
            guard (200..<300).contains(response.response?.statusCode ?? 0) else {
                print("Wrong Status Code")
                return
            }
            
            guard let responseModel = try? JSONDecoder().decode(RealtimeWeatherResponse.self, from: data) else {
                print("Decode error")
                return
            }
            print(responseModel)
        }
    }
    
    private func makeUrlComponents(for weatherType: WeatherRequestPath, place: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.baseUlr
        components.path = weatherType.rawValue  //"/current.json"
        components.queryItems = [URLQueryItem(name: "q", value: place)]
        return components
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
