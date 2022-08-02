//
//  MovieSerieToggle.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 2/8/22.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
 
            Spacer()
 
            Image(systemName: configuration.isOn ? "sparkles.tv" : "film")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .blue)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
            }
        }
     }
}
