//
//  PropertiesListPresenter.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import Foundation

final class PropertiesListPresenter: BasePresenter, PropertiesListPresenterProtocol {
    
    // MARK: - Properties
    
    public weak var signalDelegate: PropertiesListSignalDelegate?
    public weak var ui: PropertiesListPresenterDelegate?
    var _sections: [PropertiesListViewController.Model.Section] = []
    let interactor: PropertiesListInteractorProtocol
    var properties: [PropertyCollectionViewCell.Model] = []
        
    // MARK: - Presenter Protocol
    
    public var title: String {
        return "Anuncios"
    }
    
    var sections: [PropertiesListViewController.Model.Section] {
        get { return _sections.isEmpty ? getSections() : _sections }
        set { _sections = newValue }
    }
    
    // MARK: - Initilization
    
    init(signalDelegate: PropertiesListSignalDelegate,
         interactor: PropertiesListInteractorProtocol) {
        self.signalDelegate = signalDelegate
        self.interactor = interactor
        super.init()
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        getProperties()
    }
    
    // MARK: - Functions
    
    func getSections() -> [PropertiesListViewController.Model.Section] {
        var sections: [PropertiesListViewController.Model.Section] = [.init(product: [])]
        
        if let properties = getPropertiesSection() {
            sections.append(properties)
        }
        
        return sections
    }
    
    private func getPropertiesSection() -> PropertiesListViewController.Model.Section? {
        let cells: [PropertiesListViewController.Model.Product] = properties.compactMap {
            .property(.init(imageURL: $0.imageURL,
                            generalInfoModel: $0.generalInfoModel,
                            isFavorite: $0.isFavorite))
        }
        
        return PropertiesListViewController.Model.Section.init(product: cells)
    }
    
    private func getProperties() {
        interactor.fetchProperties { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let properties):
                handleProperties(properties)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func handleProperties(_ properties: [Property]) {
        properties.forEach { property in
            var imageURL: URL?
            
            if let url = URL(string: property.thumbnail) {
                imageURL = url
            }
            
            let generalInfoModel = GeneralInfoView.Model(district: property.district,
                                                         municipality: property.municipality,
                                                         address: property.address,
                                                         price: property.priceInfo.price?.amount ?? 0,
                                                         currency: property.priceInfo.price?.currencySuffix ?? "$",
                                                         rooms: property.rooms,
                                                         bathrooms: property.bathrooms,
                                                         propertyType: property.propertyType,
                                                         operationType: property.operation)
            
            self.properties.append(PropertyCollectionViewCell.Model.init(imageURL: imageURL,
                                                                         generalInfoModel: generalInfoModel))
            
            /// Calling main thread
            DispatchQueue.main.async {
                self.ui?.refresh()
            }
        }
    }
}

// MARK: - Presenteder Delegate Functions

extension PropertiesListPresenter {
    
    func didSelect(at indexPath: IndexPath) {
        signalDelegate?.signalTriggered(.goToDetail(properties[indexPath.row]))
    }
    
    func didTapFavButton(_ model: PropertyCollectionViewCell.Model, at indexPath: IndexPath) {
        model.isFavorite.toggle()
        properties[indexPath.row] = model
        _sections = []
        ui?.reloadRow(at: indexPath)
    }
}
