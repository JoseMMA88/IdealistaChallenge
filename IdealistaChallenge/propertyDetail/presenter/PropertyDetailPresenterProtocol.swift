//
//  PropertyDetailPresenterProtocol.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import Foundation

// MARK: - Signal Enum

public enum PropertyDetailSignal {
    case goBack
}

public protocol PropertyDetailSignalDelegate: AnyObject {
    func signalTriggered(_ signal: PropertyDetailSignal)
}

public protocol PropertyDetailPresenterProtocol where Self: BasePresenter {
    var ui: PropertyDetailPresenterDelegate? { get set }
    var title: String { get }
    
    var sections: [PropertyDetailViewController.Model.Section] { get set }
    var isDescExpanded: Bool { get set }
    
    func readMoreButtonTapped()
}

public protocol PropertyDetailPresenterDelegate: BasePresenterDelegate {
    func refresh()
    func reloadRow(at indexPath: IndexPath)
}
