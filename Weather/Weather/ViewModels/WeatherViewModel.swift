//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Валентина Лінчук on 22/10/2023.
//

import Foundation



class WeatherViewModel {
    var cityName: ObservableObject<String?> = ObservableObject(nil)
    var currentTemperature: ObservableObject<String?> = ObservableObject(nil)
    
    var apiWorker = WeatherApiWorker()
    var adapter = ValuesAdapter()
    var settings = Settings()
   
    
    func updateWeatherValues() {
        settings.loadFromUserDefaults()
        
        apiWorker.makeCurrentWeatherRequest { currentWeatherResponse in
         
            self.cityName.value = currentWeatherResponse.location.cityName
            self.currentTemperature.value = self.adapter.getTemperature(for: currentWeatherResponse.currentWeather, with: self.settings)
        }
    }
}
