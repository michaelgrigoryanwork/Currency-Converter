//
//  FreeCurrencyAPI.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 19.02.24.
//

import Foundation

enum FreeCurrencyAPI: APIProtocol {
    case exchangeRates(_ parameters: [String: Any?])
    
    var method: APIMethod {
        switch self {
        case .exchangeRates:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .exchangeRates:
            return basePath
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .exchangeRates(let parameters):
            return parameters.map { key, value in
                return URLQueryItem(name: key, value: value as? String)
            }
        }
    }
}
