//
//  APIService.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation

/// APIService object to get Propeties List data using Alamofire
final class APIService {
    
    // MARK: - Enums
    
    /// Service error types
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    // MARK: - Propeties
    
    /// Singleton
    static let share = APIService()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public functions
    
    // TODO: Move to Interactor
    static func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        execute(APIRequest(endPoint: .list),
                expecting: [Property].self,
                completion: completion)
    }
    
    // TODO: Move to Interactor
    static func fetchPropertyDetail(completion: @escaping (Result<PropertyDetail, Error>) -> Void) {
        execute(APIRequest(endPoint: .detail),
                expecting: PropertyDetail.self,
                completion: completion)
    }
    
    static func execute<T: Codable>(_ request: APIRequest,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(type.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Functions
        
    static func request(from apiRequest: APIRequest) -> URLRequest? {
        guard let url = apiRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        
        return request
    }
}
