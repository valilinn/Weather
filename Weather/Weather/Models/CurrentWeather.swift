//
//  CurrentWeather.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import Foundation

struct CurrentWeather: Codable {
    let lastUpdateTimestamp: UInt64
    let lastUpdateTimeFormatted: String
    let tempInCelsius: Double
    let tempInFahrenheit: Double
    private let isDayRaw: Int
    let condition: CurrentCondition
    let windInMilesPerHour: Double
    let windInKilometerPerHour: Double
    let windInDegree: Int
    let windDirection: String
    let pressureInMilliBars: Double
    let pressureInInches: Double
    let precipitationInMilliMeters: Double
    let precipitationInInches: Double
    let humidity: Int
    let cloud: Int
    let feelsLikeInCelsius: Double
    let feelsLikeInFahrenheit: Double
    let visibleInKiloMeters: Double
    let visibleInMiles: Double
    let uvFactor: Double
    let gustInMilesPerHour: Double
    let gustInKilometerPerHour: Double
    var isDay: Bool {
        get{
            isDayRaw != 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case lastUpdateTimestamp        = "last_updated_epoch"
        case lastUpdateTimeFormatted    = "last_updated"
        case tempInCelsius              = "temp_c"
        case tempInFahrenheit           = "temp_f"
        case isDayRaw                   = "is_day"
        case condition                  = "condition"
        case windInMilesPerHour         = "wind_mph"
        case windInKilometerPerHour     = "wind_kph"
        case windInDegree               = "wind_degree"
        case windDirection              = "wind_dir"
        case pressureInMilliBars        = "pressure_mb"
        case pressureInInches           = "pressure_in"
        case precipitationInMilliMeters = "precip_mm"
        case precipitationInInches      = "precip_in"
        case humidity                   = "humidity"
        case cloud                      = "cloud"
        case feelsLikeInCelsius         = "feelslike_c"
        case feelsLikeInFahrenheit      = "feelslike_f"
        case visibleInKiloMeters        = "vis_km"
        case visibleInMiles             = "vis_miles"
        case uvFactor                   = "uv"
        case gustInMilesPerHour         = "gust_mph"
        case gustInKilometerPerHour     = "gust_kph"
       
    }
}

/*
 "condition": {
     "text": "Sunny",
     "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
     "code": 1000
 },
 */

struct CurrentCondition: Codable {
    let textInfo: String
    let iconUrl: String
    let weatherCode: Int
    
    enum CodingKeys: String, CodingKey {
        case textInfo = "text"
        case iconUrl      = "icon"
        case weatherCode  = "code"
    }
}
