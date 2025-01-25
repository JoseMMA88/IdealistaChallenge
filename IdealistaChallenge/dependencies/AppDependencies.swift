//
//  AppDependencies.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation
import UIKit

public class AppDependencies: NSObject {
    static func makePropertiesList() -> PropertiesListViewController {
        let viewController = PropertiesListViewController()

        return viewController
    }
}
