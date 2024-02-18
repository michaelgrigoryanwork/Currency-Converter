//
//  APIProtocol.swift
//  Currency Converter
//
//  Created by Mikayel Grigoryan on 19.02.24.
//

import Foundation

enum APIMethod: String {
    case get
    case put
    case post
    case patch
    case delete
}

protocol APIProtocol {
    var method: APIMethod { get }
    var basePath: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    
    var bodyParameters: [String: Any?]? { get }
    var queryItems: [URLQueryItem]? { get }
    
    func asURLRequest() throws -> URLRequest
}

extension APIProtocol {
    var basePath: String {
        return "https://api.freecurrencyapi.com/v1/latest"
    }
    
    var headers: [String: String] {
        return ["apiKey": apiKey]
    }
    
    var bodyParameters: [String: Any?]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var urlBuilder = URLComponents(string: path) else {
            throw URLError(.badURL)
        }
        
        if let queryItems, !queryItems.isEmpty {
            urlBuilder.queryItems = queryItems
            urlBuilder.percentEncodedQuery = urlBuilder.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        guard let url = urlBuilder.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = headers

        urlRequest.httpMethod = method.rawValue.uppercased()
        
        if let bodyParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            } catch {
                throw error
            }
        }
        
        return urlRequest
    }
}

extension APIProtocol {
    var apiKey: String {
        if let plistPath = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let plistDict = NSDictionary(contentsOfFile: plistPath),
           let stringValue = plistDict["free_currency_api_key"] as? String {
            return stringValue
        }
        return ""
    }
}
