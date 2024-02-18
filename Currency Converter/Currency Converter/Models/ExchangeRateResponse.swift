//
//  ExchangeRateResponse.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 18.02.24.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let data: [String: Double]
}
