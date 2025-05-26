//
//  Weather_AppUITests.swift
//  Weather AppUITests
//
//  Created by Niykee Moore on 26.05.2025.
//

import XCTest

final class Weather_AppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    @MainActor
    func testAppLaunch_DisplaysLoading_ThenForecastData() throws {
        let navigationTitleText = "Прогноз: Москва"
        let navigationBar = app.navigationBars[navigationTitleText]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 10), "Навигационный заголовок '\(navigationTitleText)' должен появиться.")
        
        let loadingIndicator = app.staticTexts["Загрузка прогноза..."]
        
        if loadingIndicator.exists {
            let loadingDisappeared = expectation(for: NSPredicate(format: "exists == false"), evaluatedWith: loadingIndicator, handler: nil)
            wait(for: [loadingDisappeared], timeout: 20)
        }
        
        let temperaturePredicate = NSPredicate(format: "label CONTAINS[c] '°C'")
        let anyTemperatureText = app.staticTexts.containing(temperaturePredicate).firstMatch
        
        XCTAssertTrue(anyTemperatureText.waitForExistence(timeout: 15), "Хотя бы один элемент с температурой должен появиться в списке.")
        
        if anyTemperatureText.exists {
            let todayText = app.staticTexts["Сегодня"]
            let tomorrowText = app.staticTexts["Завтра"]
            let dayOfWeekVisible = todayText.exists || tomorrowText.exists || app.staticTexts.containing(NSPredicate(format: "label IN %@", ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"])).firstMatch.exists
            XCTAssertTrue(dayOfWeekVisible, "Отображаемое имя дня должно присутствовать.")
            
            let windPredicate = NSPredicate(format: "label CONTAINS[c] 'км/ч'")
            let anyWindText = app.staticTexts.containing(windPredicate).firstMatch
            XCTAssertTrue(anyWindText.exists, "Скорость ветра должна быть видна.")
            
            let humidityPredicate = NSPredicate(format: "label CONTAINS[c] '%'")
            let anyHumidityText = app.staticTexts.containing(humidityPredicate).firstMatch
            XCTAssertTrue(anyHumidityText.exists, "Влажность должна быть видна.")
        }
    }
}
