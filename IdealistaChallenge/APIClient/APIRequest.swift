//
//  APIRequest.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation

/// Single API Call
final class APIRequest {
    
    // MARK: - Properties
    
    private struct Constants {
        static let baseUrl = "https://idealista.github.io/ios-challenge"
    }
    
    private var stringURL: String {
        "\(Constants.baseUrl)/\(endPoint.rawValue).json"
    }
    
    public var url: URL? {
        URL(string: stringURL)
    }
    
    public let endPoint: APIEndPoint
    public let httpMethod = "GET"
    
    // MARK: - Initializers
    
    /// Inicializer
    /// - Parameters:
    ///   - endPoint: API EndPoint
    public init(endPoint: APIEndPoint) {
        self.endPoint = endPoint
    }
    
}
