//
//  ValuesAdapter.swift
//  Weather
//
//  Created by Валентина Лінчук on 01/10/2023.
//

import Foundation

class ValuesAdapter {
    
    func getTemperature(for info: CurrentWeather, with settings: Settings) -> String {
        switch settings.temperature {
        case .celsius:
            return "\(info.tempInCelsius) \(TemperatureType.celsius.rawValue)"
        case .fahrenheit:
            return "\(info.tempInFahrenheit) \(TemperatureType.fahrenheit.rawValue)"
        }
        
    }
    
    func getWindVelocity(for info: CurrentWeather, with settings: Settings) -> String {
        switch settings.windVelocity {
        case .mph:
            return "\(info.windInMilesPerHour) \(WindVelocityType.mph.rawValue)"
        case .kph:
            return "\(info.windInKilometerPerHour) \(WindVelocityType.kph.rawValue)"
        case .mps:
            return "\(info.windInKilometerPerHour / 3.6) \(WindVelocityType.mps.rawValue)"
        }
    }
    
    func getPressure(for info: CurrentWeather, with settings: Settings) -> String {
        switch settings.pressure {
        case .mbar:
            return "\(info.pressureInMilliBars) \(PressureType.mbar.rawValue)"
        case .inches:
            return "\(info.pressureInInches) \(PressureType.inches.rawValue)"
        }
    }
    
    func getPrecipitation(for info: CurrentWeather, with settings: Settings) -> String {
        switch settings.precipitation {
        case .mm:
            return "\(info.precipitationInMilliMeters) \(PrecipitationType.mm.rawValue)"
        case .inches:
            return "\(info.precipitationInInches) \(PrecipitationType.inches.rawValue)"
        }
    }
    
    func getVisibleSpace(for info: CurrentWeather, with settings: Settings) -> String {
        switch settings.space {
        case .km:
            return "\(info.visibleInKiloMeters) \(SpaceType.km.rawValue)"
        case .miles:
            return "\(info.visibleInMiles) \(SpaceType.miles.rawValue)"
        }
    }
}
