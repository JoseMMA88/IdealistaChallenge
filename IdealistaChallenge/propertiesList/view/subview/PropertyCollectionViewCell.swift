//
//  PropertyCollectionViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import UIKit

// MARK: - Model

extension PropertyCollectionViewCell {
    public struct Model {
        let imageURL: URL?
        let generalInfoModel: GeneralInfoView.Model
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
    
    lazy private var generalInfoView: GeneralInfoView = {
        let view = GeneralInfoView()
        
        return view
    }()
    
    lazy private var imageAndInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView
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
        
        contentView.fill(with: mainView)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Functions
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with model: Model) {
        generalInfoView.configure(with: model.generalInfoModel)
        imageAndInfoStackView.addArrangedSubview(generalInfoView)
        imageAndInfoStackView.layoutIfNeeded()
        
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

