//
//  ForecastDayItem.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

struct ForecastDayItem: Identifiable {
    let id = UUID()
    let date: Date
    let conditionText: String
    let iconURL: URL?
    let avgTempCelsius: Double
    let maxWindKph: Double
    let avgHumidity: Double
    
    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "E, dd.MM"
        return formatter
    }()
    
    private static let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "E"
        return formatter
    }()
    
    private static let dayAndMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }()
    
    var formattedShortDate: String {
        return ForecastDayItem.shortDateFormatter.string(from: date)
    }
    
    var dayDisplayName: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            return ForecastDayItem.dayOfWeekFormatter.string(from: date).capitalized
        }
    }
    
    var formattedDayAndMonth: String {
        return ForecastDayItem.dayAndMonthFormatter.string(from: date)
    }
}
