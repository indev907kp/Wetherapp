//
//  WeatherView.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import SwiftUI

struct WeatherView: View {
    
    @AppStorage("city") private var cityname: String = ""
    @StateObject private var viewModel = WeatherViewModel(request: HTTPRequest())
    @StateObject var locationManager = LocationManager()
    @State private var city: String = ""

    var body: some View {
        
        ZStack(alignment: .leading) {
             
            // Search View
             VStack {
                 TextField("Search city name", text: $city)
                 .onSubmit {
                     cityname = city.trimmingCharacters(in: .whitespaces)
                     viewModel.fetchWeather(for: city.trimmingCharacters(in: .whitespaces))
                 }
                 .submitLabel(.search)
                 .padding()
                 .overlay {
                     RoundedRectangle(cornerRadius: 8, style: .continuous)
                         .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                 }
                 
                 Text("Search or click on button to get current location")
                     .font(.title2).bold()
                     .multilineTextAlignment(.center)
                     .lineLimit(2)
                 
                 // Location button - When user tap on that, if user already allowed location permition then it will fetch the area or will ask to allow the permission.
                 Button(action: {
                     UIApplication.shared.windows.first{$0.isKeyWindow }?.endEditing(true)
                     switch locationManager.authorizationStatus {
                         // If permission is not allowed.
                     case .notDetermined, .restricted, .denied:
                         locationManager.requestLocationAccess()
                         
                         // If already permission is allowed.
                     case .authorizedAlways, .authorizedWhenInUse, .authorized:
                         cityname = locationManager.city ?? "Chicago"
                         viewModel.fetchWeather(for: locationManager.city ?? "Chicago")
                     default:
                         locationManager.requestLocationAccess()
                     }
                 }, label: {
                     Text("Current location")
                         .fontWeight(.bold)
                         .foregroundStyle(.white)
                         .frame(maxWidth: .infinity)
                         .padding(.vertical, 14)
                         .background(Color.blue, in: .rect(cornerRadius: 12))
                         .clipShape(RoundedRectangle(cornerRadius: 10))
                 })
                 
                 // Wether Data View
                 VStack {
                     if let weather = viewModel.weather {
                         VStack(spacing: 20) {
                             
                             // Location name
                             Text(viewModel.weather!.name)
                                 .bold().font(.system(size: 40))
                                 .padding()
                             
                             HStack(spacing: 5) {
                                 
                                 // Temperature
                                 Text("\(weather.main.temp, specifier: "%.1f")°")
                                     .font(.system(size: 40))
                                     .fontWeight(.bold)
                                 
                                 // Icone
                                 AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png"))
                                 
                                 HStack {
                                     VStack {
                                         // Weather Main
                                         Text(weather.weather.first?.main ?? "No description")
                                             .font(.title)
                                             .fontWeight(.semibold)
                                     }
                                 }
                             }
                             .padding()
                             .background(Color(.systemGray5))
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                             .shadow(color: Color(.systemFill), radius: 10, x: 0, y: 0)
                             
                             HStack(alignment: .center, spacing: 5) {
                                 
                                 VStack(alignment:.leading ,spacing:5) {
                                     
                                     // Maximum Temprature.
                                     SubrowView(icone: "thermometer",
                                                name: "Max",
                                                tem:  weather.main.temp_max.roundDouble() + "°")
                                     // Minimum Tempreature.
                                     SubrowView(icone: "thermometer",
                                                name: "Min",
                                                tem: weather.main.temp_min.roundDouble() + "°")
                                 }
                                 
                                 VStack(alignment:.leading ,spacing:5) {
                                     
                                     // Humidity
                                     SubrowView(icone: "humidity.fill",
                                                name: "Humid",
                                                tem: "\(weather.main.humidity)")
                                     
                                     //Wind Speed
                                     SubrowView(icone: "wind",
                                                name: "Wind Speed",
                                                tem: "\(weather.wind.speed)")
                                     
                                 }
                             }
                             .padding()
                             .background(Color(.systemGray5))
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                             .shadow(color: Color(.systemFill), radius: 10, x: 0, y: 0)
                         }
                     }
                 }
             }
             .padding()
            
    } // ZStack
        .frame(maxWidth: .infinity)
        .onAppear() {
            
            // Load the data if Location already searched.
            if !cityname.isEmpty {
                viewModel.fetchWeather(for: cityname)
            }
        }
    }
    
}

#Preview {
    WeatherView()
}
