//
//  ContentView.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import SwiftUI

struct WeatherListView: View {
    @State private var forecastItems: [ForecastDayItem] = MockWeatherData.getSampleForecasts()
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    
    private let cityName = "Москва"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isLoading {
                    ProgressView("Загрузка прогноза...")
                        .frame(maxHeight: .infinity)
                } else if let errorMsg = errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                            .padding(.bottom, 5)
                        Text(errorMsg)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(forecastItems) { item in
                            DailyWeatherRow(forecast: item)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Прогноз: \(cityName)")
        }
    }
}

#Preview {
    WeatherListView()
}
