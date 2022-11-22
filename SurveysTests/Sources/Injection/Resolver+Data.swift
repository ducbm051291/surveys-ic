//
//  Resolver+Data.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Resolver

@testable import Surveys

extension Resolver {

    static func registerDataServices() {
        registerServices()
        registerRepositories()
    }

    private static func registerServices() {
        mock.register { UserDefaultsManagerProtocolMock() }
            .implements(UserDefaultsManagerProtocol.self)
        mock.register { KeychainProtocolMock() }
            .implements(KeychainProtocol.self)
        mock.register { NetworkAPIProtocolMock() }
            .implements(NetworkAPIProtocol.self)
    }

    private static func registerRepositories() {
        mock.register { AuthenticationRepositoryProtocolMock() }
            .implements(AuthenticationRepositoryProtocol.self)
        mock.register { SessionRepositoryProtocolMock() }
            .implements(SessionRepositoryProtocol.self)
    }
}
