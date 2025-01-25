//
//  AppCoordinator.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation
import UIKit

public enum AppSignal {
    case propertiesList
}

public class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    let appDependencies = AppDependencies()
    let signal: AppSignal?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, signal: AppSignal) {
        self.navigationController = navigationController
        self.signal = signal
    }
    
    // MARK: - Functions
    
    public func resolve() {
        if let signal = signal {
            switch signal {
            case .propertiesList:
                navigateToPropertiesList()
            }
        }
    }
    
}

extension AppCoordinator {
    
    private func navigateToPropertiesList() {
        let vc = AppDependencies.makePropertiesList()
        navigationController.pushViewController(vc, animated: false)
    }
    
}

