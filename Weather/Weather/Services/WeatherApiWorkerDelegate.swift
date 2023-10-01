//
//  WeatherApiWorkerDelegate.swift
//  Weather
//
//  Created by Валентина Лінчук on 01/10/2023.
//

import Foundation

protocol WeatherApiWorkerDelegate: AnyObject {
    func gotRealtimeWeather(response: RealtimeWeatherResponse)
    func gotError(description: String)
}

extension WeatherApiWorkerDelegate {
    func gotError(description: String) { }
}
