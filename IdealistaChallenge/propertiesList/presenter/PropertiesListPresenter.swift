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
                            title: $0.title,
                            location: $0.location,
                            price: $0.price,
                            roomsNumber: $0.roomsNumber,
                            bathroomsNumber: $0.bathroomsNumber,
                            propertyType: $0.propertyType,
                            operationType: $0.operationType))
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
            
            let title = "\(property.propertyType.capitalized) en \(property.address) \(property.municipality)"
            let location = "\(property.district), \(property.municipality)"
            let price = formatPriceWithCurrency(property.priceInfo.price?.amount ?? 0,
                                                withCurrency: property.priceInfo.price?.currencySuffix ?? "$")
            let roomsNumberString = property.rooms > 1 ? "\(property.rooms) rooms" : "\(property.rooms) room"
            let bathNumberString = property.bathrooms > 1 ? "\(property.rooms) bathrooms" : "\(property.rooms) bathroom"
            
            self.properties.append(PropertyCollectionViewCell.Model.init(imageURL: imageURL,
                                                                         title: title,
                                                                         location: location,
                                                                         price: price,
                                                                         roomsNumber: roomsNumberString,
                                                                         bathroomsNumber: bathNumberString,
                                                                         propertyType: property.propertyType.capitalized,
                                                                         operationType: property.operation.capitalized))
            
            /// Calling main thread
            DispatchQueue.main.async {
                self.ui?.refresh()
            }
        }
    }
    
    private func formatPriceWithCurrency(_ price: Int, withCurrency currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: price)) ?? "\(price) \(currency)"
    }
}

// MARK: - Presenteder Delegate Functions

extension PropertiesListPresenter {
    
    func didSelect(at indexPath: IndexPath) {
        signalDelegate?.signalTriggered(.goToDetail(properties[indexPath.row]))
    }
    
    func didTapFavButton() {
        
    }
}
