//
//  ContentView.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import SwiftUI

struct WeatherListView: View {
    @StateObject private var viewModel: WeatherViewModel
    
    init(city: String) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(city: city))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    ProgressView("Загрузка прогноза...")
                        .frame(maxHeight: .infinity)
                } else if let errorMsg = viewModel.errorMessage {
                    Text(errorMsg)
                } else {
                    List {
                        ForEach(viewModel.forecastDays) { item in
                            DailyWeatherRow(forecast: item)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Прогноз: \(viewModel.cityName)")
            .task {
                await viewModel.loadWeatherForecast(days: 5)
            }
        }
    }
}

#Preview {
    WeatherListView(city: "Moscow")
}
