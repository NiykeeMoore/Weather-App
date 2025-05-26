//
//  ForecastDayItemTests.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import XCTest
@testable import Weather_App

final class ForecastDayItemTests: XCTestCase {
    
    func testFormattedShortDate() {
        // Given:
        let date = createDate(year: 2025, month: 12, day: 25)
        let item = ForecastDayItem(date: date, conditionText: "Тест", iconURL: nil, avgTempCelsius: 0, maxWindKph: 0, avgHumidity: 0)
        
        // When:
        let formattedDate = item.formattedShortDate
        
        // Then:
        XCTAssertTrue(formattedDate.contains("25.12"), "Отформатированная дата должна содержать день и месяц")
        XCTAssertTrue(formattedDate.starts(with: "Чт") || formattedDate.starts(with: "чт"), "Отформатированная дата должна начинаться с дня недели")
    }
    
    func testDayDisplayName_Today() {
        // Given:
        let today = Date()
        let item = ForecastDayItem(date: today, conditionText: "Тест", iconURL: nil, avgTempCelsius: 0, maxWindKph: 0, avgHumidity: 0)
        
        // When:
        let displayName = item.dayDisplayName
        
        // Then:
        XCTAssertEqual(displayName, "Сегодня")
    }
    
    func testDayDisplayName_Tomorrow() {
        // Given:
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let item = ForecastDayItem(date: tomorrow, conditionText: "Тест", iconURL: nil, avgTempCelsius: 0, maxWindKph: 0, avgHumidity: 0)
        
        // When:
        let displayName = item.dayDisplayName
        
        // Then:
        XCTAssertEqual(displayName, "Завтра")
    }
    
    func testDayDisplayName_OtherDay() {
        // Given:
        let twoDaysLater = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let item = ForecastDayItem(date: twoDaysLater, conditionText: "Тест", iconURL: nil, avgTempCelsius: 0, maxWindKph: 0, avgHumidity: 0)
        
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.locale = Locale(identifier: "ru_RU")
        dayOfWeekFormatter.dateFormat = "E"
        let expectedDayName = dayOfWeekFormatter.string(from: twoDaysLater).capitalized
        
        // When:
        let displayName = item.dayDisplayName
        
        // Then:
        XCTAssertEqual(displayName, expectedDayName)
    }
    
    func testFormattedDayAndMonth() {
        // Given:
        let date = createDate(year: 2025, month: 7, day: 15) // 15 июля
        let item = ForecastDayItem(date: date, conditionText: "Тест", iconURL: nil, avgTempCelsius: 0, maxWindKph: 0, avgHumidity: 0)
        
        // When:
        let formatted = item.formattedDayAndMonth
        
        // Then:
        XCTAssertEqual(formatted, "15 июля")
    }
    
    // MARK: - Helpers
    private func createDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.timeZone = TimeZone(identifier: "Europe/Moscow")
        return Calendar.current.date(from: components)!
    }
}
