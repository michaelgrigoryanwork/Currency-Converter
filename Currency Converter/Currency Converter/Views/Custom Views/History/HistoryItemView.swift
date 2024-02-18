//
//  HistoryItemView.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 19.02.24.
//

import SwiftUI

struct HistoryItemView: View {
    let itemViewModel: HistoryItemViewModel
    
    var body: some View {
        HStack {
            ItemView(alignment: .leading,
                     currency: itemViewModel.selectedCurrency,
                     value: itemViewModel.selectedCurrencyValue,
                     title: Strings.selectedCurrency)
            
            Spacer()
                        
            ItemView(alignment: .trailing,
                currency: itemViewModel.targetCurrency,
                     value: itemViewModel.targetCurrencyValue,
                     title: Strings.targetCurrency)
        }
        .frame(height: Spacings.spacing64)
        .padding(.horizontal, Spacings.spacing16)
        .background(.accent)
        .clipShape(RoundedRectangle(cornerRadius: Spacings.spacing8))
    }
}

private extension HistoryItemView {
    struct ItemView: View {
        let alignment: HorizontalAlignment
        let currency: Currency
        let value: String
        let title: String
        
        var body: some View {
            VStack(alignment: alignment) {
                HStack(spacing: HistoryItemView.Spacings.spacing4) {
                    Text(currency.countryEmoji)
                    Text(title)
                }
                .lineLimit(1)
                .font(.caption)
                
                HStack(spacing: HistoryItemView.Spacings.spacing4) {
                    Text(value)
                    Text(currency.shortTitle)
                }
                .lineLimit(1)
                .font(.title3)
            }
            .foregroundStyle(.white)
        }
    }
}

fileprivate extension HistoryItemView {
    struct Strings {
        static let selectedCurrency = "selected_currency".localized
        static let targetCurrency = "target_currency".localized
    }
    
    struct Spacings {
        static let spacing4: CGFloat = 4.0
        static let spacing8: CGFloat = 8.0
        static let spacing16: CGFloat = 16.0
        static let spacing64: CGFloat = 64.0
    }
}

#Preview {
    HistoryItemView(itemViewModel: .init(convertionHistory: .init(id: UUID().uuidString, selectedCurrency: .RUB, targetCurrency: .EUR, selectedCurrencyValue: "1000", targetCurrencyValue: "10.09", date: Date())))
}
