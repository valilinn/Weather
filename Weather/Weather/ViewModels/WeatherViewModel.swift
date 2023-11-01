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
    var condition: ObservableObject<String?> = ObservableObject(nil)
    var hours: [ObservableObject<String?>] = [ObservableObject(nil)]
    var imageInHours: [ObservableObject<String?>] = [ObservableObject(nil)]
    var tempInHours: [ObservableObject<String?>] = [ObservableObject(nil)]
    var dayOfTheWeek: [ObservableObject<String?>] = [ObservableObject(nil)]
    var imageOfTheDay: [ObservableObject<String?>] = [ObservableObject(nil)]
    var minTempOfTheDay: [ObservableObject<String?>] = [ObservableObject(nil)]
    var maxTempOfTheDay: [ObservableObject<String?>] = [ObservableObject(nil)]
    
    var apiWorker = WeatherApiWorker()
    var adapter = ValuesAdapter()
    var settings = Settings()
    var completionHandler: (() -> Void)?
    
    func updateWeatherValues() {
        settings.loadFromUserDefaults()
        DispatchQueue.global().async { [weak self] in
            self?.apiWorker.makeCurrentWeatherRequest { currentWeatherResponse in
                self?.cityName.value = currentWeatherResponse.location.cityName
                self?.currentTemperature.value = self?.adapter.getTemperature(for: currentWeatherResponse.currentWeather, with: self?.settings ?? Settings())
                self?.condition.value = currentWeatherResponse.currentWeather.condition.textInfo
                self?.updateHours(currentWeatherResponse)
                self?.updateImagesInHours(currentWeatherResponse)
                self?.updateTempInHours(currentWeatherResponse)
                self?.updateDays(currentWeatherResponse)
            }
        }
    }
    
    
    private func updateHours(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var timeArray = [String]()
        var hoursArray: [ObservableObject<String?>] = []
        let currentHour = getCurrentHour()
        for (_, day) in currentWeatherResponse.forecastWeather.forecastDay.enumerated() {
            for (_, hour) in day.hour.enumerated() {
                if let timeIndex = hour.time.firstIndex(of: " ") {
                    let time = hour.time[timeIndex...].trimmingCharacters(in: .whitespaces)
                    timeArray.append(time)
                }
            }
        }
        if let currentIndex = timeArray.firstIndex(of: currentHour) {
            print(currentIndex)
            let hoursStartingFromCurrent = Array(timeArray[currentIndex..<timeArray.count]) + Array(timeArray[0..<currentIndex])
//            print(hoursStartingFromCurrent)
            for time in hoursStartingFromCurrent {
                let observableTime = ObservableObject<String?>(time)
                hoursArray.append(observableTime)
            }
        }
        self.hours = hoursArray
        self.completionHandler?()
    }
    
    
    
    
    private func updateImagesInHours(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var imagesArray: [ObservableObject<String?>] = []
        let currentHour = getCurrentHour()
        let currentHourChar = String(currentHour.prefix(2))
        var imagesStringArray = [String]()
        for day in currentWeatherResponse.forecastWeather.forecastDay {
            for hour in day.hour {
                imagesStringArray.append(hour.condition.forecastIcon)
            }
        }
        for index in Int(currentHourChar)!..<imagesStringArray.count {
            let observableTime = ObservableObject<String?>(imagesStringArray[index])
            imagesArray.append(observableTime)
        }
        self.imageInHours = imagesArray
        self.completionHandler?()
        
    }
   
    private func updateTempInHours(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var tempArray: [ObservableObject<String?>] = []
        let currentHour = getCurrentHour()
        let currentHourChar = String(currentHour.prefix(2))
        var tempStringArray = [String]()
        for day in currentWeatherResponse.forecastWeather.forecastDay {
            for hour in day.hour {
                switch settings.temperature {
                case .celsius:
                    tempStringArray.append(String(hour.tempInCelsius) + " °C")
                case .fahrenheit:
                    tempStringArray.append(String(hour.tempInFahrenheit) + " °F")
                }
                
            }
        }
        for index in Int(currentHourChar)!..<tempStringArray.count {
            let observableTemp = ObservableObject<String?>(tempStringArray[index])
            tempArray.append(observableTemp)
        }
        self.tempInHours = tempArray
        self.completionHandler?()
        
    }
    
    private func updateDays(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var daysArray: [ObservableObject<String?>] = []
        for day in currentWeatherResponse.forecastWeather.forecastDay {
            let observableDay = ObservableObject<String?>(getCurrentDay(day.date))
            daysArray.append(observableDay)
        }
        self.dayOfTheWeek = daysArray
        self.completionHandler?()
    }
    
}

private func getCurrentHour() -> String {
    var currentHour = String()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:00"
        let dateString = dateFormatter.string(from: currentDate) // date with current timezone
        currentHour = dateString
        return currentHour
    }
    
    private func getCurrentDay(_ day: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: day) {
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date)
            print(calendar.weekdaySymbols[dayOfWeek - 1])
            return calendar.weekdaySymbols[dayOfWeek - 1]
            
        }
        return ""
    }

