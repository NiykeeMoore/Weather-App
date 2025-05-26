//
//  NetworkErrorTests.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//


import XCTest
@testable import Weather_App

class NetworkErrorTests: XCTestCase {
    
    func testErrorDescription_apiKeyMissing() {
        // Given:
        let error = NetworkError.apiKeyMissing
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "API ключ отсутствует или некорректен.")
    }
    
    func testErrorDescription_invalidURL() {
        // Given:
        let error = NetworkError.invalidURL
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "Некорректный URL запроса.")
    }
    
    func testErrorDescription_requestFailed() {
        // Given:
        struct DummyError: Error, LocalizedError { var errorDescription: String? { "Внутренняя ошибка" } }
        let underlyingError = DummyError()
        let error = NetworkError.requestFailed(underlyingError)
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "Сетевой запрос не удался: Внутренняя ошибка")
    }
    
    func testErrorDescription_requestFailedWithNSError() {
        // Given:
        let nsError = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Описание NSError"])
        let error = NetworkError.requestFailed(nsError)
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "Сетевой запрос не удался: Описание NSError")
    }
    
    func testErrorDescription_invalidResponse() {
        // Given:
        let error = NetworkError.invalidResponse
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "Получен некорректный ответ от сервера.")
    }
    
    func testErrorDescription_decodingError() {
        // Given:
        struct DummyError: Error, LocalizedError { var errorDescription: String? { "Ошибка парсинга" } }
        let underlyingError = DummyError()
        let error = NetworkError.decodingError(underlyingError)
        
        // When:
        let description = error.errorDescription
        
        // Then;
        XCTAssertEqual(description, "Ошибка декодирования данных: Ошибка парсинга")
    }
    
    func testErrorDescription_httpError() {
        // Given:
        let error = NetworkError.httpError(statusCode: 404, data: nil)
        
        // When:
        let description = error.errorDescription
        
        // Then:
        XCTAssertEqual(description, "Ошибка HTTP: статус 404.")
    }
}
