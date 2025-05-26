//
//  APIConstants.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import Foundation

enum APIConstants {
    static let scheme = "https"
    static let host = "api.weatherapi.com"
    static let path = "/v1/forecast.json"

    static let apiKey = "4532086cce9e46ce98e174702252605"

    static var baseURL: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
}
