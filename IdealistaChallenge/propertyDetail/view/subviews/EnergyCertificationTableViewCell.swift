//
//  EnergyCertificationTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import UIKit

// MARK: - Model

extension EnergyCertificationTableViewCell {
    public struct Model {
        let energyConsumptionType: String
        let emissionsType: String
    }
}

// MARK: - TableViewCell

public final class EnergyCertificationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.text = "Certificado energético"
        
        return label
    }()
    
    lazy private var energyConsumptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var energyConsumptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy private var emissionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    lazy private var emissionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy private var energyView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [
            energyConsumptionStackView,
            emissionsStackView
        ])
        stackView.spacing = 5
        stackView.axis = .vertical
        
        let view = UIView()
        view.fill(with: stackView, edges: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        return stackView
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            energyView
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
        energyConsumptionStackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        emissionsStackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    public func configure(with model: Model) {
        titleLabel.text = "Certificado energético"
        energyConsumptionLabel.text = "- Consumo: "
        emissionsLabel.text = "- Emisiones: "
        
        energyConsumptionStackView.addArrangedSubview(energyConsumptionLabel)
        energyConsumptionStackView.addArrangedSubview(createTypeLabelView(with: model.emissionsType))
        energyConsumptionStackView.addArrangedSubview(UIView())
        
        emissionsStackView.addArrangedSubview(emissionsLabel)
        emissionsStackView.addArrangedSubview(createTypeLabelView(with: model.emissionsType))
        emissionsStackView.addArrangedSubview(UIView())
    }
    
    private func createTypeLabelView(with text: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGreen
        
        let label = UILabel()
        label.text = "e"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemBackground
        
        view.fill(with: label, edges: UIEdgeInsets(top: 0,
                                                   left: 2,
                                                   bottom: 0,
                                                   right: 0))
        
        // Create eLabel
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 15, y: 0))
        path.addLine(to: CGPoint(x: 15, y: 0))
        path.addLine(to: CGPoint(x: 30, y: 10))
        path.addLine(to: CGPoint(x: 15, y: 20))
        path.addLine(to: CGPoint(x: 0, y: 20))
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        view.layer.mask = shapeLayer
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 30),
            view.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return view
    }
}
