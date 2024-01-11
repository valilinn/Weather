//
//  Location.swift
//  Weather
//
//  Created by Валентина Лінчук on 01/11/2023.
//

//import Foundation
//import CoreLocation
//
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    var locationManager = CLLocationManager()
//
//    func fetchLocation() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // Желаемая точность
//        locationManager.requestWhenInUseAuthorization() // Запрос разрешения на использование геолокации
//        locationManager.startUpdatingLocation() // Начать получение геолокации
//    }
//
//    // Обработка полученной геолокации
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> String {
//        var fullLocation = String()
//        guard let location = locations.last else { return }
//        let latitude = location.coordinate.latitude
//        let longitude = location.coordinate.longitude
//        print("Широта: \(latitude), Долгота: \(longitude)")
//        fullLocation = "\(latitude),\(longitude)"
//        return fullLocation
//    }
//
//    // Обработка ошибок получения геолокации
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Ошибка при получении геолокации: \(error.localizedDescription)")
//    }
//}
