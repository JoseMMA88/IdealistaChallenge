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
    var _sections: [PropertyDetailViewController.Model.Section] = []
    public weak var ui: PropertyDetailPresenterDelegate?
    let interactor: PropertyDetailInteractorProtocol
    var propertyDetail: PropertyDetail?
    var isDescExpanded: Bool = false
        
    // MARK: - Presenter Protocol
    
    public var title: String {
        return "Detalles de la propiedad"
    }
    
    var sections: [PropertyDetailViewController.Model.Section] {
        get { return _sections.isEmpty ? getSections() : _sections }
        set { _sections = newValue }
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
        getPropertyDetail()
    }
    
    // MARK: - Functions
    
    func getSections() -> [PropertyDetailViewController.Model.Section] {
        var sections: [PropertyDetailViewController.Model.Section] = [.init(product: [])]
        
        if let properties = getPropertyDetailSection() {
            sections.append(properties)
        }
        
        return sections
    }
    
    private func getPropertyDetailSection() -> PropertyDetailViewController.Model.Section? {
        guard let propertyDetail = propertyDetail else { return nil }
        
        var cells: [PropertyDetailViewController.Model.Product] = [
            .carousel(imagesUrls: propertyDetail.multimedia.images.compactMap { URL(string: $0.url) })
        ]
        
        let descriptionCell: PropertyDetailViewController.Model.Product = .description(.init(price: propertyDetail.priceInfo.amount ?? 0,
                                                                                             currency: propertyDetail.priceInfo.currencySuffix ?? "$",
                                                                                             description: propertyDetail.propertyComment,
                                                                                             isExpanded: isDescExpanded,
                                                                                             action: {
            self.isDescExpanded.toggle()
            DispatchQueue.main.async {
                self.ui?.refresh()
            }
        }))
        
        cells.append(descriptionCell)
        
        return PropertyDetailViewController.Model.Section.init(product: cells)
    }
    
    private func getPropertyDetail() {
        interactor.fetchPropertyDetail { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let propertyDetail):
                self.propertyDetail = propertyDetail
                DispatchQueue.main.async {
                    self.ui?.refresh()
                }
            case .failure(let error):
                self.signalDelegate?.signalTriggered(.goBack)
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - Presenteder Delegate Functions

extension PropertiesListPresenter {
    
}
