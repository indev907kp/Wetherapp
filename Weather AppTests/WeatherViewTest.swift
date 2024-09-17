//
//  WeatherViewTest.swift
//  Weather AppTests
//
//  Created by niravkumar patel on 9/17/24.
//

import Foundation
import Combine
import XCTest

@testable import Weather_App

final class MealsListTests: XCTestCase {
       
    // Success Case
    func testMealsList_Successfull() {
        
        let aspectedData = WeatherResponse(
            coord: Coord(lon: -87.65, lat: 41.85),
            weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03n")],
            main: Main(temp: 74.01, feels_like: 73.74, temp_min: 70.05, temp_max: 75.04, pressure: 1019, humidity: 56,sea_level: 1019, grnd_level: 998), wind: Wind(speed: 4.61, deg: 100), clouds: Clouds(all: 40), sys: Sys(country: "US", sunrise: 1726486341, sunset: 1726531102), name: "Chicago")
        
        let mockService = MockWeatherService()
        let cancellable: AnyCancellable?
        
        let data = mockService.loadJson(fileName: "MealsListResponse")
        mockService.result = .success(data!)
        
        // system under test
        let sut = WeatherViewModel(request: mockService)
        let expectation = XCTestExpectation(description: "Feching Meals")
        
        cancellable = sut.$weather
            .dropFirst()
            .sink(receiveValue: { data in
                XCTAssertEqual(data?.main.humidity, 56)
                XCTAssertEqual(data?.weather.first?.main, "Clouds")
                XCTAssertNil(sut.responseError)
                expectation.fulfill()
            })
        
       // sut.fetchMealsListWith("Dessert")
        wait(for: [expectation], timeout: 1)
    }
    
    // Failure Case
    func test_MealsList_Failure() {
        
        let mockService = MockWeatherService()
        mockService.result = .failure(MockError.defaultError)

        let sut = WeatherViewModel(request: mockService)
        sut.fetchWeather(for: "")
        XCTAssertEqual(sut.responseError, "Location not found")
        XCTAssertNotNil(sut.responseError)
    }
}
