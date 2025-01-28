//
//  PropertiesListPresenterProtocol.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

// MARK: - Signal Enum

public enum PropertiesListSignal {
    case goToDetail(PropertyCollectionViewCell.Model)
}

public protocol PropertiesListSignalDelegate: AnyObject {
    func signalTriggered(_ signal: PropertiesListSignal)
}

public protocol PropertiesListPresenterProtocol where Self: BasePresenter {
    
    var ui: PropertiesListPresenterDelegate? { get set }
    var title: String { get }
    
    var sections: [PropertiesListViewController.Model.Section] { get set }
    
    func didSelect(at indexPath: IndexPath)
    func didTapFavButton(_ model:PropertyCollectionViewCell.Model, at indexPath: IndexPath)
    func refreshData(completion: @escaping () -> Void)
}

public protocol PropertiesListPresenterDelegate: BasePresenterDelegate {
    func refresh()
    func reloadRow(at indexPath: IndexPath)
}
