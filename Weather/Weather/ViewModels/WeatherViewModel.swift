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
    var detailedInfo: [ObservableObject<String?>] = [ObservableObject(nil)]
    var detailedNames = ["Wind", "Pressure", "Precipitation", "Visibility"]
    
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
                self?.updateDetailedInfo(currentWeatherResponse)
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
        var imagesArray: [ObservableObject<String?>] = []
        var minTempArray: [ObservableObject<String?>] = []
        var maxTempArray: [ObservableObject<String?>] = []
        for day in currentWeatherResponse.forecastWeather.forecastDay {
            let observableDay = ObservableObject<String?>(getCurrentDay(day.date))
            daysArray.append(observableDay)
            let observableImage = ObservableObject<String?>(day.day.condition.forecastIcon)
            imagesArray.append(observableImage)
            switch settings.temperature {
            case .celsius:
                let observableMinTemp = ObservableObject<String?>(String(day.day.minTempInCelsius) + " °C")
                minTempArray.append(observableMinTemp)
                let observableMaxTemp = ObservableObject<String?>(String(day.day.maxTempInCelsius) + " °C")
                maxTempArray.append(observableMaxTemp)
            case .fahrenheit:
                let observableMinTemp = ObservableObject<String?>(String(day.day.minTempInFahrenheit) + " °F")
                minTempArray.append(observableMinTemp)
                let observableMaxTemp = ObservableObject<String?>(String(day.day.maxTempInFahrenheit) + " °F")
                maxTempArray.append(observableMaxTemp)
                
            }
            
        }
        self.dayOfTheWeek = daysArray
        self.minTempOfTheDay = minTempArray
        self.maxTempOfTheDay = maxTempArray
        self.imageOfTheDay = imagesArray
        self.completionHandler?()
    }
    
    private func updateDetailedInfo(_ currentWeatherResponse: RealtimeWeatherResponse) {
        var detailedArray: [ObservableObject<String?>] = []
        switch settings.windVelocity {
        case .mph:
            let observableWind = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.windInMilesPerHour) + " mph")
            detailedArray.append(observableWind)
        case .kph:
            let observableWind = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.windInKilometerPerHour) + " km/h")
            detailedArray.append(observableWind)
        case .mps:
            let observableWind = ObservableObject<String?>(String(Int(currentWeatherResponse.currentWeather.windInKilometerPerHour / 3.6)) + " m/s")
            detailedArray.append(observableWind)
        }
        switch settings.pressure {
        case .mbar:
            let observablePressure = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.pressureInMilliBars) + " mbar")
            detailedArray.append(observablePressure)
        case .inches:
            let observablePressure = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.pressureInInches) + " inHg")
            detailedArray.append(observablePressure)
        }
        
        switch settings.precipitation {
        case .mm:
            let observablePrecipitation = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.precipitationInMilliMeters) + " mm")
            detailedArray.append(observablePrecipitation)
        case .inches:
            let observablePrecipitation = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.precipitationInInches) + " in")
            detailedArray.append(observablePrecipitation)
        }
        
        switch settings.space {
        case .km:
            let observableSpace = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.visibleInKiloMeters) + "km")
            detailedArray.append(observableSpace)
        case .miles:
            let observableSpace = ObservableObject<String?>(String(currentWeatherResponse.currentWeather.visibleInMiles) + " miles")
            detailedArray.append(observableSpace)
        }
        
        self.detailedInfo = detailedArray
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
}
