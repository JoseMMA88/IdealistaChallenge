//
//  PropertyDetailPresenter.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import Foundation

final class PropertyDetailPresenter: BasePresenter, PropertyDetailPresenterProtocol {
    
    
    // MARK: - Properties
    
    public weak var signalDelegate: PropertyDetailSignalDelegate?
    public weak var ui: PropertyDetailPresenterDelegate?
    let interactor: PropertyDetailInteractorProtocol
        
    // MARK: - Presenter Protocol
    
    public var title: String {
        return "Detalles de la propiedad"
    }
    
    // MARK: - Initilization
    
    init(signalDelegate: PropertyDetailSignalDelegate,
         interactor: PropertyDetailInteractorProtocol) {
        self.signalDelegate = signalDelegate
        self.interactor = interactor
        super.init()
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        
    }
    
    // MARK: - Functions
}

// MARK: - Presenteder Delegate Functions

extension PropertiesListPresenter {
    
}
