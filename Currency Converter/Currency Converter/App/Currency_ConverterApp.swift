//
//  Currency_ConverterApp.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 17.02.24.
//

import SwiftUI
import SwiftData

@main
struct Currency_ConverterApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ConvertionHistory.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: .init(apiService: .init(), converterService: .init()))
        }
        .modelContainer(modelContainer)
    }
}
