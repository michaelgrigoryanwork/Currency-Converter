//
//  HistoryItemViewModel.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 19.02.24.
//

import Foundation

struct HistoryItemViewModel {
    var selectedCurrency: Currency {
        return convertionHistory.selectedCurrency
    }
    
    var targetCurrency: Currency {
        return convertionHistory.targetCurrency
    }
    
    var selectedCurrencyValue: String {
        return convertionHistory.selectedCurrencyValue
    }
    
    var targetCurrencyValue: String {
        return convertionHistory.targetCurrencyValue
    }
    
    private let convertionHistory: ConvertionHistory
    
    init(convertionHistory: ConvertionHistory) {
        self.convertionHistory = convertionHistory
    }
}
