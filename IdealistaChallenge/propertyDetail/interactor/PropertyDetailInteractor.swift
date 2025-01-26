//
//  PropertyDetailInteractor.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

final class PropertyDetailInteractor: BaseInteractor, PropertyDetailInteractorProtocol {
    
    func fetchPropertyDetail(completion: @escaping (Result<PropertyDetail, Error>) -> Void) {
        APIService.execute(APIRequest(endPoint: .detail),
                           expecting: PropertyDetail.self,
                           completion: completion)
    }
}
