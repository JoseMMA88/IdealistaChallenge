//
//  PropertiesListInteractorProtocol.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

public protocol PropertiesListInteractorProtocol where Self: BaseInteractor {
    func fetchProperties(completion: @escaping (Result<[Property], Error>) -> Void)
}
