//
//  ImagesCarouselTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 27/1/25.
//

import SwiftUI
import UIKit

class ImagesCarouselTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    private var hostingController: UIHostingController<ImagesCarouselView>?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configure(with urls: [URL]) {
        hostingController = UIHostingController(rootView: ImagesCarouselView(imageUrls: urls))
        
        if let view = hostingController?.view {
            contentView.fill(with: view, edges: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
        }
    }
}
