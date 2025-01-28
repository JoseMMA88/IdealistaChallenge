//
//  PropertyDetailPresenterTests.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 28/1/25.
//

import XCTest
@testable import IdealistaChallenge

class MockPropertyDetailSignalDelegate: PropertyDetailSignalDelegate {
    var signalTriggedCalled = false
    var signal: PropertyDetailSignal!
    
    func signalTriggered(_ signal: PropertyDetailSignal) {
        self.signalTriggedCalled = true
        self.signal = signal
    }
}

class MockPropertyDetailInteractor: BaseInteractor, PropertyDetailInteractorProtocol {
    var fetchDataCalled = false
    var mockPropertyDetail: (Result<IdealistaChallenge.PropertyDetail, any Error>)?
    
    func fetchPropertyDetail(completion: @escaping (Result<IdealistaChallenge.PropertyDetail, any Error>) -> Void) {
        fetchDataCalled = true
    }
}

class MockPropertyDetailPresenterDelegate: PropertyDetailPresenterDelegate {
    var refreshCalled = false
    var reloadRowCalled = false
    
    func refresh() {
        refreshCalled = true
    }
    
    func reloadRow(at indexPath: IndexPath) {
        reloadRowCalled = true
    }
}

final class PropertyDetailPresenterTests: XCTestCase {
    
    var presenter: PropertyDetailPresenter!
    var mockSignalDelegate: PropertyDetailSignalDelegate!
    var mockInteractor: MockPropertyDetailInteractor!
    var mockUI: MockPropertyDetailPresenterDelegate!
    
    override func setUp() {
        super.setUp()
        
        mockSignalDelegate = MockPropertyDetailSignalDelegate()
        mockInteractor = MockPropertyDetailInteractor()
        mockUI = MockPropertyDetailPresenterDelegate()
        presenter = PropertyDetailPresenter(signalDelegate: mockSignalDelegate,
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
        XCTAssertEqual(presenter.title, "property_detail_title".localized)
    }
    
    func testFetchPropertyDetail() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchDataCalled)
    }
    
    func testReadMoreBtnTappedOpen() {
        presenter.readMoreButtonTapped()
        XCTAssertTrue(presenter.isDescExpanded)
        XCTAssertTrue(mockUI.reloadRowCalled)
    }
    
    func testReadMoreBtnTappedClose() {
        presenter.readMoreButtonTapped()
        presenter.readMoreButtonTapped()
        XCTAssertFalse(presenter.isDescExpanded)
        XCTAssertTrue(mockUI.reloadRowCalled)
    }
    
}
