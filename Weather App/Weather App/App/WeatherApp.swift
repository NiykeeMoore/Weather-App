//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherAPIService()
            let viewModel = WeatherViewModel(city: "Москва", weatherService: weatherService)
            WeatherListView(viewModel: viewModel)
        }
    }
}
