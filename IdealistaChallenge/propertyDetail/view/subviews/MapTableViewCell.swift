//
//  MapTableViewCell.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 28/1/25.
//

import UIKit
import MapKit

// MARK: - Model

extension MapTableViewCell {
    public struct Model {
        let latitude: Double
        let longitude: Double
    }
}

public final class MapTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isScrollEnabled = false
        map.isZoomEnabled = false
        
        NSLayoutConstraint.activate([
            map.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        return map
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.fill(with: mapView, edges: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Functions
    
    func configure(with model: Model) {
        let location = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: false)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}
