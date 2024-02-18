//
//  APIService.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 18.02.24.
//

import SwiftUI

final class APIService {
    func request<T: Decodable>(_ route: APIProtocol) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: route.asURLRequest())
        print(response)
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
