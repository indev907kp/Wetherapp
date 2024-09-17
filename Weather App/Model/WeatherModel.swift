//
//  WeatherModel.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case sys = "sys"
        case name = "name"
    }
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

struct Clouds: Decodable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct Sys: Decodable {
    let country: String
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}
