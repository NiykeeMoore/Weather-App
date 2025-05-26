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
            WeatherListView(city: "Москва")
        }
    }
}
