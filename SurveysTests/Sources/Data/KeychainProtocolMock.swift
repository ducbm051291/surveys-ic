//
//  KeychainProtocolMock.swift
//  SurveysTests
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Surveys

final class KeychainProtocolMock: KeychainProtocol {

    var data = [String: Any?]()

    func remove(_ key: Keychain.Key) throws {
        data.removeValue(forKey: key.rawValue)
    }

    func set<T>(_ value: T?, for key: Keychain.Key) throws where T: Encodable {
        data[key.rawValue] = value
    }

    func get<T>(_ key: Keychain.Key) throws -> T? where T: Decodable {
        data[key.rawValue] as? T
    }

    func set(_ value: String, for key: Keychain.Key) throws {
        data[key.rawValue] = value
    }

    func removeAll() throws {
        data = [:]
    }
}
