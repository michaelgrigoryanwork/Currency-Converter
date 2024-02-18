//
//  MenuItem.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 18.02.24.
//

import Foundation

struct MenuItem: Identifiable {
    let id: String
    let emoji: String
    let title: String
    
    var fullTitle: String {
        return String(format: "%@ %@", emoji, title)
    }
}
