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
    var _isDescExpanded: Bool = false
        
    // MARK: - Presenter Protocol
    
    public var title: String {
        return "property_detail_title".localized
    }
    
    var sections: [PropertyDetailViewController.Model.Section] {
        get { return _sections.isEmpty ? getSections() : _sections }
        set { _sections = newValue }
    }
    
    var isDescExpanded: Bool {
        get { return _isDescExpanded }
        set { _isDescExpanded = newValue }
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
        
        let currencySufix = propertyDetail.priceInfo.currencySuffix?.localized ?? "$"
        let descriptionCell: PropertyDetailViewController.Model.Product = .description(.init(price: propertyDetail.priceInfo.amount ?? 0,
                                                                                             currency: currencySufix,
                                                                                             description: propertyDetail.propertyComment,
                                                                                             isExpanded: isDescExpanded))
        cells.append(descriptionCell)
        
        let moreCharacteristics = propertyDetail.moreCharacteristics
        let communityCosts = moreCharacteristics.communityCosts
        let flatLocation = moreCharacteristics.flatLocation
        let constructedArea = moreCharacteristics.constructedArea
        let moreCharacteristicsCell: PropertyDetailViewController.Model.Product = .moreCharacteristics(.init(communityCosts: communityCosts,
                                                                                                             flatLocation: flatLocation,
                                                                                                             constructedArea: constructedArea,
                                                                                                             floor: moreCharacteristics.floor,
                                                                                                             status: moreCharacteristics.status,
                                                                                                             lift: moreCharacteristics.lift,
                                                                                                             boxroom: moreCharacteristics.boxroom,
                                                                                                             isDuplex: moreCharacteristics.isDuplex))
        cells.append(moreCharacteristicsCell)
        
        let energyCertType = moreCharacteristics.energyCertificationType
        let emissionsType = moreCharacteristics.energyCertificationType
        let energyCertificationCell: PropertyDetailViewController.Model.Product = .energyCertification(.init(energyConsumptionType: energyCertType,
                                                                                                             emissionsType: emissionsType))
        cells.append(energyCertificationCell)
        
        let mapCell: PropertyDetailViewController.Model.Product = .map(.init(latitude: propertyDetail.ubication.latitude,
                                                                             longitude: propertyDetail.ubication.longitude))
        
        cells.append(mapCell)
        
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

extension PropertyDetailPresenter {
    
    func readMoreButtonTapped() {
        _isDescExpanded.toggle()
        ui?.reloadRow(at: IndexPath(row: 1, section: 1))
    }
}
