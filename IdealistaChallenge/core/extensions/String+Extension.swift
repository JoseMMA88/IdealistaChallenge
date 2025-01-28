//
//  String+Extension.swift
//  IdealistaChallenge
//
//  Created by Jose Manuel Malagón Alba on 28/1/25.
//

extension String {
    var localized: String {
        return String(localized: String.LocalizationValue(self))
    }
}
