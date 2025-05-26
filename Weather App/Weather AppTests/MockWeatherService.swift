//
//  MockWeatherService.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import Foundation
@testable import Weather_App

final class MockWeatherService: WeatherService {
    var fetchWeatherForecastResult: Result<WeatherAPIResponse, NetworkError>?
    var fetchWeatherForecastCalledWith: (city: String, days: Int)?
    var fetchWeatherForecastCallCount = 0
    
    func fetchWeatherForecast(for city: String, days: Int) async throws -> WeatherAPIResponse {
        fetchWeatherForecastCalledWith = (city, days)
        fetchWeatherForecastCallCount += 1
        
        guard let result = fetchWeatherForecastResult else {
            print("MockWeatherService.fetchWeatherForecastResult not set. Returning an empty successful response as fallback.")
            return WeatherAPIResponse(forecast: ForecastData(forecastDay: []))
        }
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    static func createMockResponse(forecastDays: [ForecastDay] = []) -> WeatherAPIResponse {
        return WeatherAPIResponse(forecast: ForecastData(forecastDay: forecastDays))
    }
    
    static func createMockForecastDay(
        date: String = "2025-05-27",
        dateEpoch: Int = Int(Date().timeIntervalSince1970),
        avgTempC: Double = 20.0,
        maxWindKph: Double = 10.0,
        avgHumidity: Double = 50.0,
        conditionText: String = "Солнечно",
        conditionIcon: String = "//cdn.weatherapi.com/weather/64x64/day/113.png"
    ) -> ForecastDay {
        let condition = ConditionData(text: conditionText, icon: conditionIcon)
        let dayData = DayData(avgTempC: avgTempC, maxWindKph: maxWindKph, avgHumidity: avgHumidity, condition: condition)
        return ForecastDay(date: date, dateEpoch: dateEpoch, day: dayData)
    }
}
