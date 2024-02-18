//
//  String+Localization.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import Foundation

extension String {
    var localized: String {
        return String(localized: .init(self))
    }
}
