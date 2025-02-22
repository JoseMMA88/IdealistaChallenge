//
//  MoreCharacteristicsTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: - Model

extension MoreCharacteristicsTableViewCell {
    public struct Model {
        let communityCosts: Int
        let flatLocation: String
        let constructedArea: Int
        let floor: String
        let status: String
        let lift: Bool
        let boxroom: Bool
        let isDuplex: Bool
    }
}

// MARK: - TableViewCell

public final class MoreCharacteristicsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.text = "basic_features".localized
        
        return label
    }()
    
    lazy private var characteristicsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            characteristicsStackView
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
    
    // MARK: - Functions
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        characteristicsStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    public func configure(with model: Model) {
        titleLabel.text = "basic_features".localized
        characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "localization_bullet".localized,
                                                                             value: model.flatLocation.localized.capitalized))
        characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "square_meters_bullet".localized,
                                                                             value: "\(model.constructedArea) m²"))
        characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "floor_bullet".localized,
                                                                             value: model.floor.localized.capitalized))
        characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "status_bullet".localized,
                                                                             value: model.status.localized.capitalized))
        
        if model.lift {
            characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "with_lift".localized))
        }
        
        if model.boxroom {
            characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "with_boxroom".localized))
        }
        
        if model.isDuplex {
            characteristicsStackView.addArrangedSubview(createCharacteristicView(with: "duplex".localized))
        }
    }
    
    private func createCharacteristicView(with title: String, value: String? = "") -> CharacteristicView {
        let view = CharacteristicView()
        view.configure(with: CharacteristicView.Model(title: title, value: value ?? ""))
        
        return view
    }
}

