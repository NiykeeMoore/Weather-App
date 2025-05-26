//
//  ForecastData.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ForecastData: Decodable {
    let forecastDay: [ForecastDay]
    
    private enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}
