//
//  Environment.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum Environment {

    static func value<T>(for key: Key) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue)
        else { throw Error.missingKey }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { throw Error.invalidValue }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

// MARK: - Enums

extension Environment {

    enum Key: String {

        case apiBaseURL = "API_BASE_URL"
    }

    enum Error: Swift.Error {

        case missingKey, invalidValue
    }
}
