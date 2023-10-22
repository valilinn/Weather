//
//  WeatherApiWorker.swift
//  Weather
//
//  Created by Валентина Лінчук on 01/10/2023.
//

import Foundation
import Alamofire


enum WeatherRequestPath: String {
    case currentWeather = "/forecast.json"
}

class WeatherApiWorker {
    private let baseUlr = "weatherapi-com.p.rapidapi.com"
    private let apiKey = "1513a718cdmsh8029cf744888920p14a113jsn282b8a4b7b33"
    var currentCity = "Tychy"
    
    public weak var delegate: WeatherApiWorkerDelegate?
    
    func makeCurrentWeatherRequest() {
        let urlComponents = makeUrlComponents(for: .currentWeather, place: currentCity)
        let headers: HTTPHeaders = HTTPHeaders([
            "X-RapidAPI-Key" : self.apiKey,
            "X-RapidAPI-Host" : self.baseUlr
        ])
        
        AF.request(urlComponents, headers: headers).response { [weak self] response in
            guard response.error == nil else {
                print("WeatherApiWorker: Request error")
                self?.delegate?.gotError(description: "Request error")
                return
            }
            
            guard let data = response.data else {
                print("WeatherApiWorker: Response error")
                self?.delegate?.gotError(description: "Response error")
                return
            }
            
            guard (200..<300).contains(response.response?.statusCode ?? 0) else {
                print("WeatherApiWorker: Wrong Status code")
                self?.delegate?.gotError(description: "Wrong Status error")
                return
            }
            
            guard let responseModel = try? JSONDecoder().decode(RealtimeWeatherResponse.self, from: data) else {
                print("WeatherApiWorker: Decode error")
                self?.delegate?.gotError(description: "Decode error")
                return
            }
//            print("WeatherApiWorker: \(responseModel)")
            self?.delegate?.gotRealtimeWeather(response: responseModel)
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
