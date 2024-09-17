//
//  APIs.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import Foundation

enum API {
    case searchCity(param:String)
    case getCity(param:String)
}

extension API: RequestComponents {
    
    var params: String {
        switch self {
        case .searchCity(let type): return type
        case .getCity(param: let coordinate): return coordinate
        }
    }
    
    var path: String {
        switch self {
        case .searchCity: return "data/2.5/weather?q="
        case .getCity: return "geo/1.0/reverse?"
        }
    }
    
    var baseURL: String {
        "https://api.openweathermap.org/"
    }
    
    var endpoint:String {
        "&APPID=f2ae2ce7c52c7e02ed4e6376cfc69a67&units=imperial"
    }
    
    var url: URL? {
        URL(string: "\(baseURL)\(path)\(params)\(endpoint)")
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .searchCity, .getCity : return .get
        }
    }
}
