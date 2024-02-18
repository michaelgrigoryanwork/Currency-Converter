//
//  MainViewModel.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String?

    @Published var selectedCurrency: Currency = .RUB
    @Published var targetCurrency: Currency = .USD
    
    @Published var selectedCurrencyValue: String = "" {
        didSet {
            if selectedCurrencyValue.isEmpty {
                targetCurrencyValue = ""
            }
        }
    }
    @Published var targetCurrencyValue: String = ""
    
    private var exchangeData: [Currency: Double] = [:]
    
    func menuItems(excludedCurrency: Currency? = nil) -> [MenuItem] {
        let currencies = Currency.allCases
        var menuItems = [MenuItem]()
        currencies.forEach { currency in
            if currency != excludedCurrency {
                menuItems.append(MenuItem(id: currency.id,
                                          emoji: currency.countryEmoji,
                                          title: String(format: "%@ (%@)", currency.longTitle, currency.shortTitle)))
            }
        }
        return menuItems
    }
    
    private let apiService: APIService
    private let converterService: ConverterService

    init(apiService: APIService, converterService: ConverterService) {
        self.apiService = apiService
        self.converterService = converterService
    }
}

extension MainViewModel {
    func changeSelectedCurrency(menuItem: MenuItem) {
        guard let currency = Currency.allCases.first(where: { $0.id == menuItem.id }) else {
            return
        }
        selectedCurrency = currency
        targetCurrencyValue = ""
    }
    
    func changeTargetCurrency(menuItem: MenuItem) {
        guard let currency = Currency.allCases.first(where: { $0.id == menuItem.id }) else {
            return
        }
        targetCurrency = currency
        targetCurrencyValue = ""
    }
    
    func convertTargetCurrencyValue() {
        guard !selectedCurrencyValue.isEmpty, let ratio = exchangeData[targetCurrency] else {
            return
        }
        targetCurrencyValue = converterService.convert(value: selectedCurrencyValue,
                                                       with: ratio) ?? ""
    }
    
    func getLatestConvertion() -> ConvertionHistory {
        let latestConvertion = ConvertionHistory(id: UUID().uuidString,
                                                 selectedCurrency: selectedCurrency,
                                                 targetCurrency: targetCurrency,
                                                 selectedCurrencyValue: selectedCurrencyValue,
                                                 targetCurrencyValue: targetCurrencyValue,
                                                 date: Date())
        return latestConvertion
    }
}

extension MainViewModel {
    func fetchCurrencies() {
        Task(priority: .background, operation: {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            do {
                let parameters: [String: Any] = [
                    Keys.currencies: Currency.allCases.map({ $0.id }).joined(separator: ","),
                    Keys.baseCurrency: selectedCurrency.id
                ]
                let response: ExchangeRateResponse = try await apiService.request(FreeCurrencyAPI.exchangeRates(parameters))
                let data = response.data
                data.forEach { key, value in
                    if let currency = Currency(rawValue: key) {
                        exchangeData[currency] = value
                    }
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        })
    }
    
    struct Keys {
        static let currencies = "currencies"
        static let baseCurrency = "base_currency"
    }
}
