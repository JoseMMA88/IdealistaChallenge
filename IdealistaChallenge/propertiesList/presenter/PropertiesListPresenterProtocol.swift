//
//  PropertiesListPresenterProtocol.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

// MARK: - Signal Enum

public enum PropertiesListSignal {
    case goToDetail
}

public protocol PropertiesListSignalDelegate: AnyObject {
    func signalTriggered(_ signal: PropertiesListSignal)
}

public protocol PropertiesListPresenterProtocol where Self: BasePresenter {
    
    var ui: PropertiesListPresenterDelegate? { get set }
    var title: String { get }
    
    var sections: [PropertiesListViewController.Model.Section] { get set }
    
    func didSelect()
    func didTapFavButton()
}

public protocol PropertiesListPresenterDelegate: BasePresenterDelegate {
    func refresh()
}
