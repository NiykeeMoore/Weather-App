//
//  ConditionDataTests.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import XCTest
@testable import Weather_App

final class ConditionDataTests: XCTestCase {
    
    func testIconURL_StartsWithDoubleSlash() {
        // Given
        let condition = ConditionData(text: "Тест", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")
        
        // When
        let url = condition.iconURL
        
        // Then
        XCTAssertEqual(url?.absoluteString, "https://cdn.weatherapi.com/weather/64x64/day/113.png")
    }
    
    func testIconURL_StartsWithHttp() {
        // Given
        let condition = ConditionData(text: "Тест", icon: "http://cdn.weatherapi.com/weather/64x64/day/113.png")
        
        // When
        let url = condition.iconURL
        
        // Then
        XCTAssertEqual(url?.absoluteString, "http://cdn.weatherapi.com/weather/64x64/day/113.png")
    }
    
    func testIconURL_StartsWithHttps() {
        // Given
        let condition = ConditionData(text: "Тест", icon: "https://cdn.weatherapi.com/weather/64x64/day/113.png")
        
        // When
        let url = condition.iconURL
        
        // Then
        XCTAssertEqual(url?.absoluteString, "https://cdn.weatherapi.com/weather/64x64/day/113.png")
    }
    
    func testIconURL_InvalidOrRelativePath() {
        // Given
        let condition1 = ConditionData(text: "Тест", icon: "weather/64x64/day/113.png")
        let condition2 = ConditionData(text: "Тест", icon: "") // Пустая строка
        let condition3 = ConditionData(text: "Тест", icon: "/onlyPath.png")
        
        
        // When
        let url1 = condition1.iconURL
        let url2 = condition2.iconURL
        let url3 = condition3.iconURL
        
        // Then
        XCTAssertNil(url1, "URL должен быть nil для относительного пути без '//'")
        XCTAssertNil(url2, "URL должен быть nil для пустой строки")
        XCTAssertNil(url3, "URL должен быть nil для пути, начинающегося с одного '/'")
    }
}
