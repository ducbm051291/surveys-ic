//
//  Resolver+Domain.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Resolver

@testable import Surveys

extension Resolver {

    static func registerDomainServices() {
        registerUseCases()
    }

    private static func registerUseCases() {
        mock.register { LoginUseCaseProtocolMock() }
            .implements(LoginUseCaseProtocol.self)
        mock.register { StoreTokenUseCaseProtocolMock() }
            .implements(StoreTokenUseCaseProtocol.self)
    }
}
