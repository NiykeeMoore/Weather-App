//
//  ForecastDay.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ForecastDay: Decodable {
    let date: String
    let date_epoch: Int
    let day: DayData
}
