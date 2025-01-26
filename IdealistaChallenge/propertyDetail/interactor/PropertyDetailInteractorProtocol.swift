//
//  PropertyDetailInteractorProtocol.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

public protocol PropertyDetailInteractorProtocol where Self: BaseInteractor {
    func fetchPropertyDetail(completion: @escaping (Result<PropertyDetail, Error>) -> Void)
}
