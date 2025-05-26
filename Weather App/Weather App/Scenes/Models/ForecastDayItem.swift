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
    
    var formattedShortDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "E, dd.MM"
        return formatter.string(from: date)
    }
    
    var dayDisplayName: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Сегодня"
        } else if calendar.isDateInTomorrow(date) {
            return "Завтра"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateFormat = "E"
            return formatter.string(from: date).capitalized
        }
    }
    
    var formattedDayAndMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
}
/// временно, по хорошему в отдельном файле в тестах
struct MockWeatherData {
    static func getSampleForecasts() -> [ForecastDayItem] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")

        let today = Date()

        return [
            ForecastDayItem(
                date: today,
                conditionText: "Солнечно",
                iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png"),
                avgTempCelsius: 22.0,
                maxWindKph: 15.0,
                avgHumidity: 60.0
            ),
            ForecastDayItem(
                date: calendar.date(byAdding: .day, value: 1, to: today)!,
                conditionText: "Переменная облачность",
                iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/116.png"),
                avgTempCelsius: 19.5,
                maxWindKph: 20.0,
                avgHumidity: 65.0
            ),
            ForecastDayItem(
                date: calendar.date(byAdding: .day, value: 2, to: today)!,
                conditionText: "Небольшой дождь",
                iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/296.png"),
                avgTempCelsius: 17.0,
                maxWindKph: 25.0,
                avgHumidity: 75.0
            ),
            ForecastDayItem(
                date: calendar.date(byAdding: .day, value: 3, to: today)!,
                conditionText: "Облачно",
                iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/119.png"),
                avgTempCelsius: 18.0,
                maxWindKph: 18.0,
                avgHumidity: 70.0
            ),
            ForecastDayItem(
                date: calendar.date(byAdding: .day, value: 4, to: today)!,
                conditionText: "Местами грозы",
                iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/386.png"),
                avgTempCelsius: 20.0,
                maxWindKph: 22.0,
                avgHumidity: 80.0
            )
        ]
    }
}
