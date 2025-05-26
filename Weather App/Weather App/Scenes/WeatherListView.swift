//
//  ContentView.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import SwiftUI

struct WeatherListView<ViewModel: WeatherViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
    let weatherService = WeatherAPIService()
    let viewModel = WeatherViewModel(city: "Москва", weatherService: weatherService)
    WeatherListView(viewModel: viewModel)
}
