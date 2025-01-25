//
//  Property.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation

struct Property: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Int
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Int
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features
}

struct PriceInfo: Codable {
    let price: Price?
    let amount: Int?
    let currencySuffix: String?
}

struct Price: Codable {
    let amount: Int
    let currencySuffix: String
}

struct Multimedia: Codable {
    let images: [Image]
}

struct Image: Codable {
    let url: String
    let tag: String
    let localizedName: String?
    let multimediaId: Int?
}

struct Features: Codable {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
}
