//
//  PropertiesListPresenterTests.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 28/1/25.
//

import XCTest
@testable import IdealistaChallenge


class MockPropertiesListSignalDelegate: PropertiesListSignalDelegate {
    var signalTriggedCalled = false
    var signal: PropertiesListSignal!
    
    func signalTriggered(_ signal: PropertiesListSignal) {
        self.signalTriggedCalled = true
        self.signal = signal
    }
}

class MockPropertiesListInteractor: BaseInteractor, PropertiesListInteractorProtocol {
    var fetchDataCalled = false
    var mockPropertyDetail: (Result<IdealistaChallenge.PropertyDetail, any Error>)?
    
    func fetchProperties(completion: @escaping (Result<[Property], any Error>) -> Void) {
        fetchDataCalled = true
    }
}

class MockPropertiesListPresenterDelegate: PropertiesListPresenterDelegate {
    var refreshCalled = false
    var reloadRowCalled = false
    
    func refresh() {
        refreshCalled = true
    }
    
    func reloadRow(at indexPath: IndexPath) {
        reloadRowCalled = true
    }
}

final class PropertiesListPresenterTests: XCTestCase {
    
    var presenter: PropertiesListPresenter!
    var mockSignalDelegate: PropertiesListSignalDelegate!
    var mockInteractor: MockPropertiesListInteractor!
    var mockUI: MockPropertiesListPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        
        mockSignalDelegate = MockPropertiesListSignalDelegate()
        mockInteractor = MockPropertiesListInteractor()
        mockUI = MockPropertiesListPresenterDelegate()
        presenter = PropertiesListPresenter(signalDelegate: mockSignalDelegate,
                                            interactor: mockInteractor)
        presenter.ui = mockUI
    }
    
    override func tearDown() {
        presenter = nil
        mockSignalDelegate = nil
        mockInteractor = nil
        mockUI = nil
        super.tearDown()
    }
    
    func testPresenterInitialization() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertEqual(presenter.title, "property_list_title".localized)
    }
    
    func testFetchPropertyDetail() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchDataCalled)
    }
    
    func testFavButtonTap() {
        let model = PropertyCollectionViewCell.Model(imageURL: nil,
                                                     generalInfoModel: .init(district: "test",
                                                                             municipality: "test",
                                                                             address: "test",
                                                                             price: 1,
                                                                             currency: "test",
                                                                             rooms: 1,
                                                                             bathrooms: 1,
                                                                             propertyType: "test",
                                                                             operationType: "test"))
        presenter.properties = [model]
        presenter.didTapFavButton(model, at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockUI.reloadRowCalled)
        XCTAssertTrue(model.isFavorite)
    }
    
}
