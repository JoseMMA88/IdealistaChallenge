//
//  PropertyCollectionViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import UIKit

// MARK: - Cell Delegate

protocol PropertyCollectionViewCellDelegate: AnyObject {
    func propertyCollectionViewCell(_ cell: PropertyCollectionViewCell,
                                    didTapFavoriteButtonWith model: PropertyCollectionViewCell.Model)
}

// MARK: - Model

extension PropertyCollectionViewCell {
    public class Model {
        let imageURL: URL?
        let generalInfoModel: GeneralInfoView.Model
        var isFavorite: Bool = false

        init(imageURL: URL?,
             generalInfoModel: GeneralInfoView.Model,
             isFavorite: Bool = false) {
            self.imageURL = imageURL
            self.generalInfoModel = generalInfoModel
            self.isFavorite = isFavorite
        }
        
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
    
    weak var delegate: PropertyCollectionViewCellDelegate?
    var model: Model?
    
    // MARK: - Views
    
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
    
    lazy private var contactStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contactView,
            VerticalSpacerView(space: 12)
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    lazy private var favImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        let button = UIButton()
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        
        imageView.fill(with: button)
        
        return imageView
    }()
    
    lazy private var favDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentColor")
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.isHidden = true
        label.textAlignment = .center
        
        return label
    }()
    
    lazy private var favView: UIView = {
        let view = UIView()
        view.center(view: favImageView)
        
        return view
    }()
    
    lazy private var favLabelView: UIView = {
        let view = UIView()
        view.center(view: favDateLabel)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        return view
    }()
    
    lazy private var favStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            favImageView,
            favLabelView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    lazy private var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contactStackView,
            favStackView
        ])
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy private var buttonsView: UIView = {
        let view = UIView()
        view.fill(with: buttonsStackView, edges: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16))
        
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
        contentView.bringSubviewToFront(favImageView)
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
        favDateLabel.text = nil
    }
    
    public func configure(with model: Model) {
        self.model = model
        generalInfoView.configure(with: model.generalInfoModel)
        imageAndInfoStackView.addArrangedSubview(generalInfoView)
        imageAndInfoStackView.layoutIfNeeded()
        
        let imageName = model.isFavorite ? "heart.fill" : "heart"
        favImageView.image = UIImage(systemName: imageName)
        
        if model.isFavorite {
            favDateLabel.isHidden = false
            favDateLabel.text = getDateString()
        } else {
            favDateLabel.isHidden = true
            favDateLabel.text = ""
        }
        
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
    
    @objc func favButtonTapped() {
        guard let model = model else { return }
        delegate?.propertyCollectionViewCell(self, didTapFavoriteButtonWith: model)
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.separator.cgColor
    }
    
    private func getDateString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: currentDate)
    }
        
}

