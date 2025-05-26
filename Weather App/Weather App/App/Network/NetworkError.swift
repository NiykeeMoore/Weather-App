//
//  NetworkError.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import Foundation

enum NetworkError: Error, LocalizedError {
    case apiKeyMissing
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case httpError(statusCode: Int, data: Data?)
    
    var errorDescription: String? {
        switch self {
        case .apiKeyMissing:
            return "API ключ отсутствует или некорректен."
        case .invalidURL:
            return "Некорректный URL запроса."
        case .requestFailed(let error):
            return "Сетевой запрос не удался: \(error.localizedDescription)"
        case .invalidResponse:
            return "Получен некорректный ответ от сервера."
        case .decodingError(let error):
            return "Ошибка декодирования данных: \(error.localizedDescription)"
        case .httpError(let statusCode, _):
            return "Ошибка HTTP: статус \(statusCode)."
        }
    }
}
