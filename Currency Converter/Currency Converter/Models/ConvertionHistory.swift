//
//  ConvertionHistory.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 18.02.24.
//

import SwiftUI
import SwiftData

@Model
final class ConvertionHistory: ObservableObject, Equatable {
    @Attribute(.unique) let id: String
    let selectedCurrency: Currency
    let targetCurrency: Currency
    let selectedCurrencyValue: String
    let targetCurrencyValue: String
    let date: Date
    
    init(id: String, selectedCurrency: Currency, targetCurrency: Currency, selectedCurrencyValue: String, targetCurrencyValue: String, date: Date) {
        self.id = id
        self.selectedCurrency = selectedCurrency
        self.targetCurrency = targetCurrency
        self.selectedCurrencyValue = selectedCurrencyValue
        self.targetCurrencyValue = targetCurrencyValue
        self.date = date
    }
}
