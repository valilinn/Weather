//
//  ForecastWeather.swift
//  Weather
//
//  Created by Валентина Лінчук on 22/10/2023.
//

import Foundation

struct ForecastWeather: Codable {
    let forecastDay: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day  = "day"
        case hour = "hour"
    }
}

struct Day: Codable {
    let maxTempInCelsius: Double
    let maxTempInFahrenheit: Double
    let minTempInCelsius: Double
    let minTempInFahrenheit: Double
    let condition: ForecastCondition
    
    enum CodingKeys: String, CodingKey {
        case maxTempInCelsius    = "maxtemp_c"
        case maxTempInFahrenheit = "maxtemp_f"
        case minTempInCelsius    = "mintemp_c"
        case minTempInFahrenheit = "mintemp_f"
        case condition           = "condition"
    }
}

struct ForecastCondition: Codable {
    let forecastIcon: String
    
    enum CodingKeys: String, CodingKey {
        case forecastIcon = "icon"
    }
}

struct Hour: Codable {
    let time: String
    let tempInCelsius: Double
    let tempInFahrenheit: Double
    let condition: ForecastCondition
    
    enum CodingKeys: String, CodingKey {
        case time             = "time"
        case tempInCelsius    = "temp_c"
        case tempInFahrenheit = "temp_f"
        case condition        = "condition"
    }
}
