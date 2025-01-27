//
//  PropertyDetailViewController.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: -  Model Section

extension PropertyDetailViewController {
    public struct  Model {
        public enum Product {
            case carrousel
        }
        
        public struct Section {
            var product: [Product]
        }
        
        var sections: [Section]
    }
}

public final class PropertyDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: PropertyDetailPresenterProtocol
    
    // MARK: - Views
    
    // MARK: - initializers
    
    init(presenter: PropertyDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        title = presenter.title
        presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Presenter Delegate

extension PropertyDetailViewController: PropertyDetailPresenterDelegate {
    
    public func refresh() {
    }
}
