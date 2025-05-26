//
//  WeatherAPIService.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import Foundation

protocol WeatherService {
    func fetchWeatherForecast(for city: String, days: Int) async throws -> WeatherAPIResponse
}

final class WeatherAPIService: WeatherService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchWeatherForecast(for city: String, days: Int) async throws -> WeatherAPIResponse {
        guard !APIConstants.apiKey.isEmpty else {
            throw NetworkError.apiKeyMissing
        }
        
        guard let baseURL = APIConstants.baseURL else {
            throw NetworkError.invalidURL
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "key", value: APIConstants.apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: String(days)),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
            }
            
            let decoder = JSONDecoder()
            
            do {
                let weatherResponse = try decoder.decode(WeatherAPIResponse.self, from: data)
                return weatherResponse
            } catch let decodingError {
                throw NetworkError.decodingError(decodingError)
            }
            
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
