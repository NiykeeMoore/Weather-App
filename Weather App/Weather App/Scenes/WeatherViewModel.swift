//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import SwiftUI

@MainActor
protocol WeatherViewModelProtocol: ObservableObject {
    var forecastDays: [ForecastDayItem] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var cityName: String { get }

    func loadWeatherForecast(days: Int) async
    func updateCity(name: String)
}

@MainActor
final class WeatherViewModel: WeatherViewModelProtocol {
    
    @Published var forecastDays: [ForecastDayItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published private(set) var cityName: String
    
    private let weatherService: WeatherService
    
    init(city: String, weatherService: WeatherService = WeatherAPIService()) {
        self.cityName = city
        self.weatherService = weatherService
    }
    
    func loadWeatherForecast(days: Int = 5) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await weatherService.fetchWeatherForecast(for: cityName, days: days)
            
            self.forecastDays = (
                response.forecast.forecastDay.map { apiDayForecast -> ForecastDayItem in
                    let date = Date(timeIntervalSince1970: TimeInterval(apiDayForecast.dateEpoch))
                    let iconUrl = apiDayForecast.day.condition.iconURL
                    
                    return ForecastDayItem(
                        date: date,
                        conditionText: apiDayForecast.day.condition.text,
                        iconURL: iconUrl,
                        avgTempCelsius: apiDayForecast.day.avgTempC,
                        maxWindKph: apiDayForecast.day.maxWindKph,
                        avgHumidity: apiDayForecast.day.avgHumidity
                    )
                }
            )
            
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
            self.forecastDays = []
        } catch {
            self.errorMessage = "Произошла неизвестная ошибка. Пожалуйста, попробуйте снова."
            self.forecastDays = []
        }
        
        self.isLoading = false
    }
    
    func updateCity(name: String) {
        self.cityName = name
    }
}
