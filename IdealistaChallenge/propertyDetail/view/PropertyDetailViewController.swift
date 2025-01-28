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
            case carousel(imagesUrls: [URL])
            case description(DescriptionTableViewCell.Model)
            case moreCharacteristics(MoreCharacteristicsTableViewCell.Model)
            case energyCertification(EnergyCertificationTableViewCell.Model)
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
    var sections: [Model.Section]
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.backgroundColor = .systemBackground
        tableView.register(ImagesCarouselTableViewCell.self,
                           forCellReuseIdentifier: ImagesCarouselTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.self,
                           forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(MoreCharacteristicsTableViewCell.self,
                           forCellReuseIdentifier: MoreCharacteristicsTableViewCell.identifier)
        tableView.register(EnergyCertificationTableViewCell.self,
                           forCellReuseIdentifier: EnergyCertificationTableViewCell.identifier)
        
        return tableView
    }()
    
    // MARK: - initializers
    
    init(presenter: PropertyDetailPresenterProtocol) {
        self.presenter = presenter
        self.sections = presenter.sections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = presenter.title
        presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.fill(with: tableView)
    }
}

// MARK: - UITableViewDelegate

extension PropertyDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension PropertyDetailViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].product.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section.product[indexPath.row] {
        case .carousel(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImagesCarouselTableViewCell.identifier,
                                                           for: indexPath) as? ImagesCarouselTableViewCell else {
                
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
            
        case .description(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier,
                                                           for: indexPath) as? DescriptionTableViewCell else {
                
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
            
        case .moreCharacteristics(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreCharacteristicsTableViewCell.identifier,
                                                           for: indexPath) as? MoreCharacteristicsTableViewCell else {
                
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
            
        case .energyCertification(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EnergyCertificationTableViewCell.identifier,
                                                           for: indexPath) as? EnergyCertificationTableViewCell else {
                
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        }
    }
}

// MARK: - Presenter Delegate

extension PropertyDetailViewController: PropertyDetailPresenterDelegate {
    
    public func refresh() {
        sections = presenter.sections
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
}
