//
//  UserDefaultsManager.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol UserDefaultsManagerProtocol {

    func set(_ value: Any?, for key: UserDefaultsKey)
    func value(for key: UserDefaultsKey) -> Any?
    func bool(for key: UserDefaultsKey) -> Bool
    func remove(for key: UserDefaultsKey)
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {

    static let `default` = UserDefaultsManager()

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func set(_ value: Any?, for key: UserDefaultsKey) {
        if let value = value {
            userDefaults.set(value, forKey: key.rawValue)
        } else {
            remove(for: key)
        }
    }

    func value(for key: UserDefaultsKey) -> Any? {
        userDefaults.value(forKey: key.rawValue)
    }

    func bool(for key: UserDefaultsKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }

    func remove(for key: UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
