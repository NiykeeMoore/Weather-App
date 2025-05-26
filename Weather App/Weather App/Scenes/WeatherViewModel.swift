//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var forecastDays: [ForecastDayItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published private(set) var cityName: String
    
    private let weatherService: WeatherAPIService
    
    init(city: String, weatherService: WeatherAPIService = WeatherAPIService()) {
        self.cityName = city
        self.weatherService = weatherService
    }
    
    func loadWeatherForecast(days: Int = 5) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await weatherService.fetchWeatherForecast(for: cityName, days: days)
            
            self.forecastDays = (
                response.forecast.forecastday.map { apiDayForecast -> ForecastDayItem in
                    let date = Date(timeIntervalSince1970: TimeInterval(apiDayForecast.date_epoch))
                    let iconUrl = apiDayForecast.day.condition.iconURL
                    
                    return ForecastDayItem(
                        date: date,
                        conditionText: apiDayForecast.day.condition.text,
                        iconURL: iconUrl,
                        avgTempCelsius: apiDayForecast.day.avgtemp_c,
                        maxWindKph: apiDayForecast.day.maxwind_kph,
                        avgHumidity: apiDayForecast.day.avghumidity
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
    
    func updateCity(name: String) async {
        self.cityName = name
    }
}
