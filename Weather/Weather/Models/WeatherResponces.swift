//
//  WeatherResponces.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import Foundation

struct RealtimeWeatherResponse: Codable {
    let location: WeatherLocation
    let currentWeather: WeatherInfo
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case currentWeather  = "current"
    }
}
