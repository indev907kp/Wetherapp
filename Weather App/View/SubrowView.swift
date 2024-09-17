//
//  SubrowView.swift
//  Weather App
//
//  Created by niravkumar patel on 9/17/24.
//

import SwiftUI

struct SubrowView: View {
    
    var icone: String
    var name: String
    var tem: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icone)
                .font(.title2)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.system(size: 12))
                
            Text(tem)
                    .bold()
                    .font(.title2)
            }
        }
        .padding()
    }
}

#Preview {
    SubrowView(icone: "humidity.fill",name: "Feels Like", tem: "8")
}
