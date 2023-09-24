//
//  Settings.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import Foundation

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

enum TemperatureType: String {
    case celsius = "°C"
    case fahrenheit = "°F"
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
}
