//
//  SpaceView.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import UIKit

/// Vertical separator view
class VerticalSpacerView: UIView {
    
    // MARK: - Initializer
    
    init(space: CGFloat, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: space).isActive = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

/// Horizontal separator view
class HorizontalSpacerView: UIView {
    
    // MARK: - Initializer
    
    init(space: CGFloat, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: space).isActive = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
