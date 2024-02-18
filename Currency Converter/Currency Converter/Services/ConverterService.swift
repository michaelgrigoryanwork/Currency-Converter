//
//  ConverterService.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import Foundation

final class ConverterService {
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }

    func convert(value: String, with ratio: Double) -> String? {
        guard let number = numberFormatter.number(from: value) else {
            return nil
        }
        
        let convertedValue = number.doubleValue * ratio
        let convertedNumber = NSNumber(floatLiteral: convertedValue)
        
        return numberFormatter.string(from: convertedNumber)
        
    }
}
