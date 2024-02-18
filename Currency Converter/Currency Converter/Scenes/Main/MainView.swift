//
//  MainView.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel: MainViewModel
    
    @FocusState private var isKeyboardFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradient()
                    .ignoresSafeArea(edges: [.bottom])
                
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .controlSize(.large)
                            .tint(.white)
                        
                        Spacer()
                    }
                    .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    VStack(alignment: .leading, spacing: Spacings.spacing16) {
                        Text(Strings.selectedCurrency)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        ConverterInputView(currency: viewModel.selectedCurrency,
                                           menuItems: viewModel.menuItems(excludedCurrency: viewModel.targetCurrency),
                                           isInputDisabled: false,
                                           value: $viewModel.selectedCurrencyValue,
                                           onCountryEmojiTap: { menuItem in
                            viewModel.changeSelectedCurrency(menuItem: menuItem)
                        })
                        .focused($isKeyboardFocused)
                        .padding(.bottom, Spacings.spacing16)
                        
                        Button {
                            viewModel.convertTargetCurrencyValue()
                            modelContext.insert(viewModel.getLatestConvertion())
                            do {
                                try modelContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            HStack(spacing: Spacings.spacing16) {
                                Spacer()
                                
                                Text(Strings.tapToConvert)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Image(systemName: Images.convert)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: Spacings.spacing24, height: Spacings.spacing24)
                                    .foregroundStyle(.white.opacity(viewModel.selectedCurrencyValue.isEmpty ? 0.5 : 1.0))
                                
                                Spacer()
                            }
                        }
                        .opacity(viewModel.selectedCurrencyValue.isEmpty ? 0.5 : 1.0)
                        .disabled(viewModel.selectedCurrencyValue.isEmpty)
                        .padding(.bottom, Spacings.spacing16)
                        
                        Text(Strings.targetCurrency)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        ConverterInputView(currency: viewModel.targetCurrency,
                                           menuItems: viewModel.menuItems(excludedCurrency: viewModel.selectedCurrency),
                                           isInputDisabled: true,
                                           value: $viewModel.targetCurrencyValue,
                                           onCountryEmojiTap: { menuItem in
                            viewModel.changeTargetCurrency(menuItem: menuItem)
                        })
                        .focused($isKeyboardFocused)
                        
                        Text(Strings.mainViewInfo)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                    }
                    .padding(.horizontal, Spacings.spacing16)
                    .padding(.top, Spacings.spacing16)
                }
            }
            .onAppear {
                viewModel.fetchCurrencies()
            }
            .navigationTitle(Strings.currencyConverter.localized)
            .modifier(NavigationBarModifier())
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button {
                        isKeyboardFocused = false
                    } label: {
                        Text(Strings.done)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    let view = HistoryView(viewModel: .init())
                    NavigationLink(destination: view) {
                        Image(systemName: Images.history)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

private extension MainView {
    struct Strings {
        static let currencyConverter: String = "currency_converter".localized
        static let done = "done".localized
        static let selectedCurrency = "selected_currency".localized
        static let targetCurrency = "target_currency".localized
        static let mainViewInfo = "main_view_info".localized
        static let tapToConvert = "tap_to_convert".localized
        static let ok = "ok".localized
    }
    
    struct Images {
        static let history = "list.bullet.clipboard"
        static let convert = "arrow.down.left.arrow.up.right"
    }
    
    struct Spacings {
        static let spacing8: CGFloat = 8.0
        static let spacing16: CGFloat = 16.0
        static let spacing24: CGFloat = 24.0
        static let spacing32: CGFloat = 32.0
        static let spacing64: CGFloat = 64.0
    }
}

#Preview {
    MainView(viewModel: .init(apiService: .init(), converterService: .init()))
}
