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
    var hours: [ObservableObject<String?>] = [ObservableObject(nil)]
    
    var apiWorker = WeatherApiWorker()
    var adapter = ValuesAdapter()
    var settings = Settings()
    var completionHandler: (() -> Void)?
    var x: Int?
    
    func updateWeatherValues() {
        settings.loadFromUserDefaults()
        print("func update")
        DispatchQueue.global().async { [weak self] in
            self?.apiWorker.makeCurrentWeatherRequest { currentWeatherResponse in
                self?.cityName.value = currentWeatherResponse.location.cityName
                self?.currentTemperature.value = self?.adapter.getTemperature(for: currentWeatherResponse.currentWeather, with: self?.settings ?? Settings())
                self?.updateHours(currentWeatherResponse)
                print(self?.x)
            }
        }
    }
    
    
    private func updateHours(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var hoursArray: [ObservableObject<String?>] = []
        for day in currentWeatherResponse.forecastWeather.forecastDay {
            for hour in day.hour {
                if let timeIndex = hour.time.firstIndex(of: " ") {
                    let time = hour.time[timeIndex...].trimmingCharacters(in: .whitespaces)
//                    print(time)
                    let observableTime = ObservableObject<String?>(time)
                    hoursArray.append(observableTime)
                }
            }
        }
        self.hours = hoursArray
        self.completionHandler?()
        print("i have hours")
        print("from model- \(self.hours[20].value)")
    }
}
