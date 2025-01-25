//
//  AppCoordinator.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation
import UIKit

public enum AppSignal {
    case houseList
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
            case .houseList:
                navigateToHouseList()
            }
        }
    }
    
}

extension AppCoordinator {
    
    private func navigateToHouseList() {
        let vc = AppDependencies.makeHouseList()
        navigationController.pushViewController(vc, animated: false)
    }
    
}

