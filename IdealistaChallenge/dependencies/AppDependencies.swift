//
//  AppDependencies.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation
import UIKit

public class AppDependencies: NSObject {
    static func makePropertiesList(signalDelegate: PropertiesListSignalDelegate) -> PropertiesListViewController {
        let interactor = PropertiesListInteractor()
        let presenter = PropertiesListPresenter(signalDelegate: signalDelegate,
                                                interactor: interactor)
        
        let viewController = PropertiesListViewController(presenter: presenter)
        presenter.ui = viewController
        
        return viewController
    }
    
    static func makePropertyDetail(with model: PropertyCollectionViewCell.Model,
                                   signalDelegate: PropertyDetailSignalDelegate) -> PropertyDetailViewController {
        let interactor = PropertyDetailInteractor()
        let presenter = PropertyDetailPresenter(signalDelegate: signalDelegate,
                                                interactor: interactor)
        
        let viewController = PropertyDetailViewController(presenter: presenter)
        presenter.ui = viewController
        
        return viewController
    }
}
