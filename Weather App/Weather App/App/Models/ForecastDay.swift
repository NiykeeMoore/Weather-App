//
//  ForecastDay.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ForecastDay: Decodable {
    let date: String
    let dateEpoch: Int
    let day: DayData
    
    private enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
    }
}
