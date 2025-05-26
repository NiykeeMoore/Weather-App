//
//  DayData.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct DayData: Decodable {
    let avgTempC: Double
    let maxWindKph: Double
    let avgHumidity: Double
    let condition: ConditionData
    
    private enum CodingKeys: String, CodingKey {
        case avgTempC = "avgtemp_c"
        case maxWindKph = "maxwind_kph"
        case avgHumidity = "avghumidity"
        case condition
    }
}
