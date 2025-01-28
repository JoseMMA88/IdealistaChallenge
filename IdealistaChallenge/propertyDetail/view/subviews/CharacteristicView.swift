//
//  CharacteristicView.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: - Model

extension CharacteristicView {
    struct Model {
        let title: String
        let value: String
    }
}

final class CharacteristicView: UIView {
    
    // MARK: - Views
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            valueLabel
        ])
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy private var mainView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [
            mainStackView,
            UIView()
        ])
        
        let view = UIView()
        view.fill(with: stackView)
        
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fill(with: mainView, edges: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    // MARK: - Functions
    
    public func configure(with model: Model) {
        titleLabel.text = "- \(model.title)"
        valueLabel.text = model.value
    }
}
