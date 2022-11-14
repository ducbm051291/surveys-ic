//
//  Parameterable.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import NimbleExtension

protocol Parameterable {}

extension Parameterable where Self: Codable {

    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        return toDictionary(encoder)
    }

    static func from(_ dictionary: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []
        ) else { return nil }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(Self.self, from: data)
    }
}
