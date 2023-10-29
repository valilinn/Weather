//
//  Sections.swift
//  Weather
//
//  Created by Валентина Лінчук on 29/10/2023.
//

import Foundation

enum SectionType {
    case mainSection
    case hourlySection
    case dailySection
    case detailSection
    
    var title: String {
        switch self {
        case .mainSection:
            return ""
        case .hourlySection:
            return "Next 24-hours"
        case .dailySection:
            return "3-days weather forecast"
        case .detailSection:
            return "Detailed weather info"
        }
    }
}

struct Sections {
//    var mainSection: SectionType
//    var hourlySection: SectionType
//    var dailySection: SectionType
//    var detailSection: SectionType
    
    var sectionsList: [SectionType] {
        [.mainSection, .hourlySection, .dailySection, .detailSection]
    }
}
