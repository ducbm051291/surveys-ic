//
//  Resolver+Domain.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Resolver

extension Resolver {

    static func registerDomainServices() {
        registerUseCases()
    }

    private static func registerUseCases() {
        register(ForgotPasswordUseCaseProtocol.self) { ForgotPasswordUseCase() }
        register(GetHasLoggedInUseCaseProtocol.self) { GetHasLoggedInUseCase() }
        register(GetSurveyListUseCaseProtocol.self) { GetSurveyListUseCase() }
        register(GetTokenUseCaseProtocol.self) { GetTokenUseCase() }
        register(LoginUseCaseProtocol.self) { LoginUseCase() }
        register(StoreTokenUseCaseProtocol.self) { StoreTokenUseCase() }
    }
}
