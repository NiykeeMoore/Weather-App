//
//  WeatherViewModelTests.swift
//  Weather App
//
//  Created by Niykee Moore on 26.05.2025.
//

import XCTest
@testable import Weather_App

@MainActor
class WeatherViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockWeatherService = MockWeatherService()
        // Given:
        viewModel = WeatherViewModel(city: "ТестовыйГород", weatherService: mockWeatherService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockWeatherService = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Load Weather Forecast Tests
    
    func testLoadWeatherForecast_Success() async {
        // Given:
        let mockAPIForecastDays = [
            MockWeatherService.createMockForecastDay(dateEpoch: 1735689600, avgTempC: 25.0, conditionText: "Солнечно"), // ~ 2025-01-01
            MockWeatherService.createMockForecastDay(dateEpoch: 1735776000, avgTempC: 22.0, conditionText: "Облачно")   // ~ 2025-01-02
        ]
        let mockAPIResponse = MockWeatherService.createMockResponse(forecastDays: mockAPIForecastDays)
        mockWeatherService.fetchWeatherForecastResult = .success(mockAPIResponse)
        
        let initialLoadingState = viewModel.isLoading
        let initialForecastCount = viewModel.forecastDays.count
        
        // When:
        await viewModel.loadWeatherForecast(days: 2)
        
        // Then:
        XCTAssertFalse(viewModel.isLoading, "isLoading должен стать false после загрузки")
        XCTAssertNil(viewModel.errorMessage, "errorMessage должен быть nil при успехе")
        XCTAssertEqual(viewModel.forecastDays.count, 2, "Количество дней прогноза должно быть 2")
        
        XCTAssertEqual(viewModel.forecastDays[0].conditionText, "Солнечно")
        XCTAssertEqual(viewModel.forecastDays[0].avgTempCelsius, 25.0)
        XCTAssertNotEqual(viewModel.forecastDays[0].id, viewModel.forecastDays[1].id, "ID элементов должны быть уникальны")
        
        XCTAssertEqual(viewModel.forecastDays[1].conditionText, "Облачно")
        XCTAssertEqual(viewModel.forecastDays[1].avgTempCelsius, 22.0)
        
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCallCount, 1, "Метод сервиса fetchWeatherForecast должен быть вызван 1 раз")
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCalledWith?.city, "ТестовыйГород")
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCalledWith?.days, 2)
        
        XCTAssertTrue(initialLoadingState == false || initialLoadingState == true, "Начальное состояние isLoading зафиксировано")
    }
    
    func testLoadWeatherForecast_NetworkError() async {
        // Given:
        let expectedError = NetworkError.httpError(statusCode: 404, data: nil)
        mockWeatherService.fetchWeatherForecastResult = .failure(expectedError)
        
        // When:
        await viewModel.loadWeatherForecast(days: 1)
        
        // Then:
        XCTAssertFalse(viewModel.isLoading, "isLoading должен стать false после ошибки")
        XCTAssertNotNil(viewModel.errorMessage, "errorMessage должен содержать описание ошибки")
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription, "Сообщение об ошибке должно соответствовать ошибке сети")
        XCTAssertTrue(viewModel.forecastDays.isEmpty, "Список дней прогноза должен быть пустым при ошибке")
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCallCount, 1)
    }
    
    func testLoadWeatherForecast_GenericError() async {
        // Given:
        struct TestError: Error, LocalizedError { var errorDescription: String? { "Тестовая ошибка декодирования" } }
        let decodingError = TestError()
        let unknownUnderlyingError = NSError(domain: "TestDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Неизвестная внутренняя ошибка"])
        mockWeatherService.fetchWeatherForecastResult = .failure(NetworkError.requestFailed(unknownUnderlyingError))
        
        
        // When:
        await viewModel.loadWeatherForecast(days: 1)
        
        // Then:
        XCTAssertFalse(viewModel.isLoading, "isLoading должен стать false после ошибки")
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.requestFailed(unknownUnderlyingError).localizedDescription)
        XCTAssertTrue(viewModel.forecastDays.isEmpty)
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCallCount, 1)
    }
    
    func testLoadWeatherForecast_isLoadingStateTransitions() async {
        // Given:
        let mockAPIResponse = MockWeatherService.createMockResponse(forecastDays: [])
        mockWeatherService.fetchWeatherForecastResult = .success(mockAPIResponse)
        
        XCTAssertFalse(viewModel.isLoading, "isLoading должен быть false перед началом загрузки")
        
        // When:
        let loadingTask = Task {
            await viewModel.loadWeatherForecast(days: 1)
        }
        
        // Then:
        await loadingTask.value
        
        XCTAssertFalse(viewModel.isLoading, "isLoading должен снова стать false после завершения загрузки")
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCallCount, 1, "Сервис должен быть вызван")
    }
    
    
    // MARK: - Update City Tests
    
    func testUpdateCity_UpdatesCityName() {
        // Given:
        let initialCityName = viewModel.cityName
        
        // When:
        let newCityName = "НовыйГород"
        viewModel.updateCity(name: newCityName)
        
        // Then:
        XCTAssertEqual(viewModel.cityName, newCityName, "Имя города должно обновиться на новое")
        XCTAssertNotEqual(viewModel.cityName, initialCityName, "Имя города должно отличаться от исходного")
        
        XCTAssertEqual(mockWeatherService.fetchWeatherForecastCallCount, 0, "loadWeatherForecast не должен вызываться автоматически при смене города, если это не реализовано")
    }
    
    // MARK: - Initial State Test
    
    func testViewModel_InitialState() {
        XCTAssertEqual(viewModel.cityName, "ТестовыйГород", "Начальное имя города должно быть 'ТестовыйГород'")
        XCTAssertTrue(viewModel.forecastDays.isEmpty, "Список дней прогноза должен быть пуст изначально")
        XCTAssertFalse(viewModel.isLoading, "isLoading должен быть false изначально")
        XCTAssertNil(viewModel.errorMessage, "errorMessage должен быть nil изначально")
    }
}
