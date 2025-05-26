//
//  ForecastData.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ForecastData: Decodable {
    let forecastday: [ForecastDay]
}
