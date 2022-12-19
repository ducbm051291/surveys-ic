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
        mock.register { ForgotPasswordUseCaseProtocolMock() }
            .implements(ForgotPasswordUseCaseProtocol.self)
        mock.register { LoginUseCaseProtocolMock() }
            .implements(LoginUseCaseProtocol.self)
        mock.register { GetTokenUseCaseProtocolMock() }
            .implements(GetTokenUseCaseProtocol.self)
        mock.register { StoreTokenUseCaseProtocolMock() }
            .implements(StoreTokenUseCaseProtocol.self)
    }
}
