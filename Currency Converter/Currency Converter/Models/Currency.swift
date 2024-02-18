//
//  Currency.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import Foundation

enum Currency: String, Identifiable, CaseIterable, Codable {
    case RUB
    case USD
    case EUR
    case GBP
    case CHF
    case CNY
    
    var id: String {
        return rawValue
    }
    
    var longTitle: String {
        switch self {
        case .RUB:
            return "russian_rubles".localized
        case .USD:
            return "us_dollars".localized
        case .EUR:
            return "euros".localized
        case .GBP:
            return "british_pounds".localized
        case .CHF:
            return "swiss_francs".localized
        case .CNY:
            return "chinese_yuan".localized
        }
    }
    
    var shortTitle: String {
        return rawValue
    }
    
    var countryEmoji: String {
        switch self {
        case .RUB:
            return "🇷🇺"
        case .USD:
            return "🇺🇸"
        case .EUR:
            return "🇪🇺"
        case .GBP:
            return "🇬🇧"
        case .CHF:
            return "🇨🇭"
        case .CNY:
            return "🇨🇳"
        }
    }
}
