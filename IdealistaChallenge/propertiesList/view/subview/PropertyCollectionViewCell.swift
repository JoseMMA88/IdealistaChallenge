//
//  PropertyCollectionViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import UIKit

// MARK: - Model

extension PropertyCollectionViewCell {
    public struct Model: Hashable {
        let imageURL: URL?
        let title: String
        let location: String
        let price: String
        let roomsNumber: String
        let bathroomsNumber: String
        let propertyType: String
        let operationType: String
        let isFavorite: Bool = false
        
        public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
            guard let url = imageURL else {
                completion(.failure(URLError(.badURL)))
                
                return
            }
            
            ImageLoader.shared.downloadImage(url, completion: completion)
        }
    }
}

public final class PropertyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 372, height: 300)
        
        let path = UIBezierPath(
            roundedRect: imageView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 8, height: 8)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        imageView.layer.mask = mask
        
        return imageView
    }()
    
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
    
    lazy private var imageAndInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            infoView
        ])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy private var contactView: UIView = {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(systemName: "text.bubble"))
        view.center(view: imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        return view
    }()
    
    lazy private var callView: UIView = {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(systemName: "phone"))
        view.center(view: imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        return view
    }()
    
    lazy private var favImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        return imageView
    }()
    
    lazy private var favView: UIView = {
        let view = UIView()
        view.center(view: favImageView)
        
        return view
    }()
    
    lazy private var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contactView,
            callView,
            favView
        ])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy private var buttonsView: UIView = {
        let view = UIView()
        view.fill(with: buttonsStackView, edges: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        
        return view
    }()
    
    lazy private var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageAndInfoStackView,
            buttonsView
        ])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    lazy private var mainView: UIView = {
        let view = UIView()
        view.fill(with: mainStackView)
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Functions
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    private func addConstraints() {
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with model: Model) {
        titleLabel.text = model.title
        locationLabel.text = model.location
        priceLabel.text = model.price
        roomsNumberLabel.text = model.roomsNumber
        bathNumberLabel.text = model.bathroomsNumber
        propertyTypeLabel.text = model.propertyType
        operationTypeLabel.text = model.operationType
        
        let imageName = model.isFavorite ? "heart.fill" : "heart"
        favImageView.image = UIImage(systemName: imageName)
        
        model.fetchImage { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.separator.cgColor
    }
}

