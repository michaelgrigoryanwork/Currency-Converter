//
//  HistoryView.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 19.02.24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) var modelContext

    @Query(sort: \ConvertionHistory.date, order: .reverse) var convertionHistory: [ConvertionHistory] = []

    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        ZStack {
            Color(.white)
            
            VStack {
                if !convertionHistory.isEmpty {
                    List {
                        ForEach(convertionHistory) { convertionHistory in
                            let itemViewModel = HistoryItemViewModel(convertionHistory: convertionHistory)
                            HistoryItemView(itemViewModel: itemViewModel)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(.init(top: Spacings.spacing16, leading: Spacings.spacing16, bottom: Spacings.spacing16, trailing: Spacings.spacing16))
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Text(Strings.noHistory)
                        .font(.title)
                        .foregroundStyle(.accent)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .navigationTitle(Strings.history)
        .modifier(NavigationBarModifier())
    }
}

private extension HistoryView {
    struct Strings {
        static let history = "history".localized
        static let noHistory = "no_history".localized
    }
    
    struct Spacings {
        static let spacing8: CGFloat = 8.0
        static let spacing16: CGFloat = 16.0
    }
}

#Preview {
    HistoryView(viewModel: .init())
}
