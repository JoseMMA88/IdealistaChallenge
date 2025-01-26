//
//  PropertiesListInteractor.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation

final class PropertiesListInteractor: BaseInteractor, PropertiesListInteractorProtocol {
    
    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void) {
        APIService.execute(APIRequest(endPoint: .list),
                           expecting: [Property].self,
                           completion: completion)
    }
}
