//
//  PropertiesListViewController.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import UIKit

// MARK: -  Model Section

extension PropertiesListViewController {
    public struct  Model {
        public enum Product {
            case property(PropertyCollectionViewCell.Model)
        }
        
        public struct Section {
            var product: [Product]
        }
        
        var sections: [Section]
    }
}

public final class PropertiesListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: PropertiesListPresenterProtocol
    var sections: [Model.Section]
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PropertyCollectionViewCell.self,
                                forCellWithReuseIdentifier: PropertyCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        
        view.fill(with: collectionView)
        
        return view
    }()
    
    // MARK: - initializers
    
    init(presenter: PropertiesListPresenterProtocol) {
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
        
        title = presenter.title
        presenter.viewDidLoad()
        view.fill(with:mainView)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - CollectionViewDelegate

extension PropertiesListViewController: UICollectionViewDelegate {
    
}

// MARK: - CollectionViewDataSource

extension PropertiesListViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].product.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section.product[indexPath.row] {
        case .property(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyCollectionViewCell.identifier,
                                                                for: indexPath) as? PropertyCollectionViewCell
            else {
                fatalError("Unsopported cell")
            }
            cell.delegate = self
            cell.configure(with: model)
            
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelect(at: indexPath)
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension PropertiesListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - Presenter Delegate

extension PropertiesListViewController: PropertiesListPresenterDelegate {
    
    public func refresh() {
        sections = presenter.sections
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    public func reloadRow(at indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - PropertiesListViewController Delegate

extension PropertiesListViewController: PropertyCollectionViewCellDelegate {
    func propertyCollectionViewCell(_ cell: PropertyCollectionViewCell,
                                    didTapFavoriteButtonWith model: PropertyCollectionViewCell.Model) {
        if let indexPath = collectionView.indexPath(for: cell) {
            presenter.didTapFavButton(model, at: indexPath)
        }
    }
}
