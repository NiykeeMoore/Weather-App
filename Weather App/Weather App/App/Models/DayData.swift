//
//  DayData.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct DayData: Decodable {
    let avgtemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
    let condition: ConditionData
}
