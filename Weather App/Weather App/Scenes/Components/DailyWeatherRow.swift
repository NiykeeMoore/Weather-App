//
//  DailyWeatherRow.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import SwiftUI

struct DailyWeatherRow: View {
    let forecast: ForecastDayItem
    
    var body: some View {
        HStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(forecast.dayDisplayName)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(forecast.formattedDayAndMonth)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 100, alignment: .leading)
            
            AsyncImage(url: forecast.iconURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 48, height: 48)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 48, height: 48)
            
            Spacer()
            
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(round(forecast.avgTempCelsius)))°C")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(forecast.conditionText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    Label {
                        Text("\(Int(round(forecast.maxWindKph))) км/ч")
                    } icon: {
                        Image(systemName: "wind")
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    
                    Label {
                        Text("\(Int(round(forecast.avgHumidity)))%")
                    } icon: {
                        Image(systemName: "humidity.fill")
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
     let mock = ForecastDayItem(
        date: Date(),
        conditionText: "Солнечно",
        iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png"),
        avgTempCelsius: 22.0,
        maxWindKph: 15.0,
        avgHumidity: 60.0
    )
    
    List {
        DailyWeatherRow(forecast: mock)
        DailyWeatherRow(forecast: mock)
        DailyWeatherRow(forecast: mock)
    }
    .listStyle(.plain)
}
