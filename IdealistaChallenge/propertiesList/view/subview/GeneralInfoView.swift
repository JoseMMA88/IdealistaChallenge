//
//  GeneralInfoView.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: - Model

extension GeneralInfoView {
    public struct Model {
        let district: String
        let municipality: String
        let address: String
        let price: Int
        let currency: String
        let rooms: Int
        let bathrooms: Int
        let propertyType: String
        let operationType: String
    }
}

public final class GeneralInfoView: UIView {
    
    // MARK: - Views
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy private var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    lazy private var roomsNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var bathNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var roomsAndBathsStackView: UIStackView = {
        let auxStackView = UIStackView(arrangedSubviews: [
            roomsNumberLabel,
            bathNumberLabel
        ])
        auxStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [
            auxStackView,
            UIView()
        ])
        
        return stackView
    }()
    
    lazy private var propertyTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy private var propertyTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemFill
        view.fill(with: propertyTypeLabel, edges: UIEdgeInsets(top: 5,
                                                               left: 10,
                                                               bottom: 5,
                                                               right: 10))
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy private var operationTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy private var operationTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemFill
        view.fill(with: operationTypeLabel, edges: UIEdgeInsets(top: 5,
                                                               left: 10,
                                                               bottom: 5,
                                                               right: 10))
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    lazy private var typesStackView: UIStackView = {
        let auxStackView = UIStackView(arrangedSubviews: [
            propertyTypeView,
            operationTypeView
        ])
        auxStackView.spacing = 10
        
        let view = UIView()
        view.fill(with: auxStackView)
        
        let stackView = UIStackView(arrangedSubviews: [
            view,
            UIView()
        ])
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    lazy private var infoView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            locationLabel,
            priceLabel,
            roomsAndBathsStackView,
            typesStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        
        let view = UIView()
        view.fill(with: stackView, edges: UIEdgeInsets(top: 20,
                                                       left: 16,
                                                       bottom: 20,
                                                       right: 16))
        
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fill(with: infoView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    public func configure(with model: Model) {
        let title = "\(model.propertyType.localized.capitalized) \("at".localized) \(model.address) \(model.municipality)"
        let location = "\(model.district), \(model.municipality)"
        let price = formatPriceWithCurrency(model.price,
                                            withCurrency: model.currency)
        let roomsNumberString = model.rooms > 1 ? "\(model.rooms) \("rooms".localized)" : "\(model.rooms) \("room".localized)"
        let bathNumberString = model.bathrooms > 1 ? "\(model.rooms) \("bathrooms".localized)" : "\(model.rooms) \("bathroom".localized)"
        
        titleLabel.text = title
        locationLabel.text = location
        priceLabel.text = price
        roomsNumberLabel.text = roomsNumberString
        bathNumberLabel.text = bathNumberString
        propertyTypeLabel.text = model.propertyType.localized.capitalized
        operationTypeLabel.text = model.operationType.localized.capitalized
    }
    
    private func formatPriceWithCurrency(_ price: Int,
                                         withCurrency currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: price)) ?? "\(price) \(currency)"
    }
}
