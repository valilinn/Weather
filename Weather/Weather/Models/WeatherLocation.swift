//
//  Location.swift
//  Weather
//
//  Created by Валентина Лінчук on 24/09/2023.
//

import Foundation

/*
 "location": {
         "name": "Tychy",
         "region": "",
         "country": "Poland",
         "lat": 50.13,
         "lon": 18.98,
         "tz_id": "Europe/Warsaw",
         "localtime_epoch": 1695552237,
         "localtime": "2023-09-24 12:43"
     },
 
 */

struct WeatherLocation: Codable {
    let cityName: String
    let stateName: String
    let countryName: String
    let latitude: Double
    let longitude: Double
    let timeZone: String
    let localTimestamp: UInt64
    let localTimeFormatted: String
    
    enum CodingKeys: String, CodingKey {
        case cityName           = "name"
        case stateName          = "region"
        case countryName        = "country"
        case latitude           = "lat"
        case longitude          = "lon"
        case timeZone           = "tz_id"
        case localTimestamp     = "localtime_epoch"
        case localTimeFormatted = "localtime"
    }
}
