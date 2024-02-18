//
//  ConverterInputView.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI

struct ConverterInputView: View {
    let currency: Currency
    let menuItems: [MenuItem]
    let isInputDisabled: Bool
    
    @Binding var value: String
    
    var onCountryEmojiTap: ((MenuItem) -> Void)?
    
    var body: some View {
        HStack(spacing: Spacings.spacing8) {
            Menu(currency.countryEmoji) {
                ForEach(menuItems) { menuItem in
                    Button {
                        onCountryEmojiTap?(menuItem)
                    } label: {
                        Text(menuItem.fullTitle)
                            .font(.title2)
                    }
                }
            }
            .font(.title2)
            .padding(.leading, Spacings.spacing8)
            
            TextField(currency.shortTitle, text: Binding(
                get: { self.value },
                set: { newValue in
                    if newValue != value {
                        self.value = newValue
                    }
                }
            ))
            .foregroundStyle(isInputDisabled ? .gray : .black)
            .font(.title2)
            .keyboardType(.decimalPad)
            .disabled(isInputDisabled)
            
            Spacer()
            
            Text(currency.longTitle)
                .font(.footnote)
                .bold()
                .multilineTextAlignment(.center)
                .minimumScaleFactor(Fonts.scaleFactorZeroPointThree)
                .frame(maxWidth: Spacings.spacing64)
                .padding(.trailing, Spacings.spacing8)
        }
        .frame(maxWidth: .infinity, maxHeight: Spacings.spacing64)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: Spacings.spacing8))
    }
}

private extension ConverterInputView {
    struct Spacings {
        static let spacing8: CGFloat = 8.0
        static let spacing64: CGFloat = 64.0
    }
    
    struct Fonts {
        static let scaleFactorZeroPointThree: CGFloat = 0.3
    }
}
