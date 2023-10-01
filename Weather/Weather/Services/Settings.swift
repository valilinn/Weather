//
//  Settings.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import Foundation

enum TemperatureType: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

enum WindVelocityType: String {
    case mph = "mph"
    case kph = "km/h"
    case mps = "m/s"
}

enum PressureType: String {
    case mbar = "mbar"
    case inches = "inHg"
}

enum PrecipitationType: String {
    case mm = "mm"
    case inches = "in"
}

enum SpaceType: String {
    case km = "km"
    case miles = "miles"
}

class Settings {
    var temperature: TemperatureType = .celsius
    var windVelocity: WindVelocityType = .kph
    var pressure: PressureType = .mbar
    var precipitation: PrecipitationType = .mm
    var space: SpaceType = .km
    
    
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(temperature.rawValue, forKey: "temperature")
        defaults.set(windVelocity.rawValue, forKey: "windVelocity")
        defaults.set(pressure.rawValue, forKey: "pressure")
        defaults.set(precipitation.rawValue, forKey: "precipitation")
        defaults.set(space.rawValue, forKey: "space")
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let temperatureRawValue = defaults.string(forKey: "temperature"),
           let temperatureType = TemperatureType(rawValue: temperatureRawValue) {
            temperature = temperatureType
        }
        
        if let windVelocityRawValue = defaults.string(forKey: "windVelocity"),
           let windVelocityType = WindVelocityType(rawValue: windVelocityRawValue) {
            windVelocity = windVelocityType
        }
        
        if let pressureRawValue = defaults.string(forKey: "pressure"),
           let pressureType = PressureType(rawValue: pressureRawValue) {
            pressure = pressureType
        }
        
        if let precipitationRawValue = defaults.string(forKey: "precipitation"),
           let precipitationType = PrecipitationType(rawValue: precipitationRawValue) {
            precipitation = precipitationType
        }
        
        if let spaceRawValue = defaults.string(forKey: "space"),
           let spaceType = SpaceType(rawValue: spaceRawValue) {
            space = spaceType
        }
    }
}
