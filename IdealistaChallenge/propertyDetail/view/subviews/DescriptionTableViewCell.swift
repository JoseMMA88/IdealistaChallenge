//
//  DescriptionTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: - Delegate

protocol DescriptionTableViewCellDelegate: AnyObject {
    func readMoreTapped()
}

// MARK: - Model

extension DescriptionTableViewCell {
    public struct Model {
        let price: Int
        let currency: String
        let description: String
        let isExpanded: Bool
    }
}

// MARK: - TableViewCell

public final class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 8
        
        return label
    }()
    
    lazy var readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("read_more".localized, for: .normal)
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(expandAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            priceLabel,
            VerticalSpacerView(space: 5),
            descriptionLabel,
            readMoreButton
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy private var mainView: UIView = {
        let view = UIView()
        view.fill(with: mainStackView, edges: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        
        return view
    }()
    
    // MARK: - Init
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .secondarySystemBackground        
        contentView.fill(with: mainView)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Propeties
    
    weak var delegate: DescriptionTableViewCellDelegate?
    var model: Model?
    
    // MARK: - Functions
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }
    
    public func configure(with model: Model) {
        self.model = model
        let price = formatPriceWithCurrency(model.price,
                                            withCurrency: model.currency)
        
        priceLabel.text = price
        descriptionLabel.text = model.description
        
        if model.isExpanded {
            descriptionLabel.numberOfLines = 0
            readMoreButton.setTitle("hide_description".localized, for: .normal)
        } else {
            descriptionLabel.numberOfLines = 8
            readMoreButton.setTitle("read_more".localized, for: .normal)
        }
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
    
    @objc func expandAction() {
        delegate?.readMoreTapped()
    }
}

