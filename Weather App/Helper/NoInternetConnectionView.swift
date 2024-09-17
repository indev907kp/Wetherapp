//
//  NoInternetConnectionView.swift
//  Weather App
//
//  Created by niravkumar patel on 9/16/24.
//

import SwiftUI

struct NoInternetConnectionView: View {
    
    @State var showView = false
    var body: some View {
            VStack {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .foregroundColor(Color.blue)
                    .frame(width: 150, height: 130)
                   
                Text("No Internet Connection")
                    .font(.title)
                    .padding(.top)
                
                Button("Try again") {
                    if Reachability.isConnectedToNetwork() {
                        showView = true
                    }
                }
                .padding(.top, 20)
                .fullScreenCover(isPresented: $showView) {
                    WeatherView()
                }
            }
        }
}

#Preview {
    NoInternetConnectionView()
}
