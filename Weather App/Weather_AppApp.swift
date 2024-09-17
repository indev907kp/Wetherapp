//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import SwiftUI

@main
struct Weather_AppApp: App {
    var body: some Scene {
        WindowGroup {
            if Reachability.isConnectedToNetwork() {
                WeatherView()
            } else {
                NoInternetConnectionView()
            }
        }
    }
}
