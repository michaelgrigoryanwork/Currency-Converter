//
//  NavigationBarModifier.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.accentColor, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
