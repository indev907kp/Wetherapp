//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private let request: HTTPRequestProtocal
    @Published var weather: WeatherResponse?
    @Published var responseError: String?

    // Dependancy Injection
    init(request: HTTPRequestProtocal) {
        self.request = request
    }
    
    func fetchWeather(for city: String) {
        
        if city != "" {
        
            let urlcomponents = URLRequestComponents(components: API.searchCity(param: city))
            
            request.performRequest(urlRequestComponents: urlcomponents) { [self] result in
                
                switch result {
                case .success(let data):
                    parseData(data)
                    responseError = nil
                case .failure(let error):
                    print(error.localizedDescription)
                    responseError = error.localizedDescription
                }
            }
        } else {
            self.responseError = "category not found"
        }
        
    }
    
    private func parseData(_ responseData: Data?)  {
        
        do {
            // Decode responsedata to Expactred Model Type
            let weathereData = try JSONDecoder().decode(WeatherResponse.self, from: responseData!)
            self.weather = weathereData
            print(self.weather?.main.temp)
        } catch {
            responseError = "Something went wrong!!!"
        }
    }

}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
