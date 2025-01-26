//
//  PropertyDetail.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 25/1/25.
//

import Foundation

public struct PropertyDetail: Codable {
    let adid: Int
    let price: Int
    let priceInfo: PriceInfo
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: Multimedia
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: MoreCharacteristics
    let energyCertification: EnergyCertification
}

struct Ubication: Codable {
    let latitude: Double
    let longitude: Double
}

struct MoreCharacteristics: Codable {
    let communityCosts: Int
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int64
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct EnergyCertification: Codable {
    let title: String
    let energyConsumption: CertificationType
    let emissions: CertificationType
}

struct CertificationType: Codable {
    let type: String
}
