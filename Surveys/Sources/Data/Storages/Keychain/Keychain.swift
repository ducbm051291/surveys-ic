//
//  Keychain.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import KeychainAccess

protocol KeychainProtocol: AnyObject {

    // String
    func get(_ key: Keychain.Key) throws -> String?
    func set(_ value: String, for key: Keychain.Key) throws

    // Codable
    func get<T: Decodable>(_ key: Keychain.Key) throws -> T?
    func set<T: Encodable>(_ value: T?, for key: Keychain.Key) throws

    // Remove
    func remove(_ key: Keychain.Key) throws
    func removeAll() throws
}

final class Keychain: KeychainProtocol {

    static let `default` = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    private let keychain: KeychainAccess.Keychain

    private init(service: String) {
        keychain = KeychainAccess.Keychain(service: service)
    }

    // MARK: - String

    func get(_ key: Keychain.Key) throws -> String? {
        try keychain.getString(key.rawValue)
    }

    func set(_ value: String, for key: Keychain.Key) throws {
        if value.isEmpty { return try remove(key) }
        try keychain.set(value, key: key.rawValue)
    }

    // MARK: - Codable

    func get<T: Decodable>(_ key: Key) throws -> T? {
        try keychain
            .getData(key.rawValue)
            .map { try JSONDecoder().decode(T.self, from: $0) }
    }

    func set<T: Encodable>(_ value: T?, for key: Key) throws {
        guard let value = value else { return try remove(key) }
        try keychain.set(JSONEncoder().encode(value), key: key.rawValue)
    }

    // MARK: - Remove

    func remove(_ key: Key) throws {
        try keychain.remove(key.rawValue)
    }

    func removeAll() throws {
        try keychain.removeAll()
    }
}

