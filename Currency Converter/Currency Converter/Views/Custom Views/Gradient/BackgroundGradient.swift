//
//  BackgroundGradient.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI

struct BackgroundGradient: View {
    let colors: [Color] = [.accentColor, .lightPurple]
    let startPoint: UnitPoint = .top
    let endPoint: UnitPoint = .bottom
    
    var body: some View {
        LinearGradient(colors: colors,
                       startPoint: startPoint,
                       endPoint: endPoint)
    }
}

#Preview {
    BackgroundGradient()
}
