//
//  UIView+Extension.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 26/1/25.
//

import UIKit

extension UIView {
    
    func fill(with view: UIView, edges: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor,
                                 constant: -edges.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                    constant: edges.bottom),
            leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                     constant: -edges.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                      constant: edges.right)
        ])
    }
    
    func center(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            view.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor)
        ])
    }
}
