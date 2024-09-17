//
//  MockWeatherService.swift
//  Weather AppTests
//
//  Created by niravkumar patel on 9/17/24.
//

import Foundation
@testable import Weather_App

class MockWeatherService: HTTPRequestProtocal {
    
    var result: Result<Data,Error>!
    
    func performRequest(urlRequestComponents: URLRequestComponents, completion: ((Result<Data, Error>) -> Void)?) {
        completion?(result)
    }
    
    // Load Json file from project
    func loadJson(fileName: String) -> Data? {
        
        guard let url = Bundle(for: MockWeatherService.self).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
    
        guard let jsondata = try? Data(contentsOf: url) else { return nil }
        return jsondata
    }
}

//MARK: Mock Error
enum MockError: Error {
    case defaultError
}
