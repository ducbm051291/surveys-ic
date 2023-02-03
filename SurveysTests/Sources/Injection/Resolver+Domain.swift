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
        mock.register { ClearQuestionResponseUseCaseProtocolMock() }
            .implements(ClearQuestionResponseUseCaseProtocol.self)
        mock.register { ForgotPasswordUseCaseProtocolMock() }
            .implements(ForgotPasswordUseCaseProtocol.self)
        mock.register { LoginUseCaseProtocolMock() }
            .implements(LoginUseCaseProtocol.self)
        mock.register { GetQuestionResponseUseCaseProtocolMock() }
            .implements(GetQuestionResponseUseCaseProtocol.self)
        mock.register { GetSurveyDetailUseCaseProtocolMock() }
            .implements(GetSurveyDetailUseCaseProtocol.self)
        mock.register { GetSurveyListUseCaseProtocolMock() }
            .implements(GetSurveyListUseCaseProtocol.self)
        mock.register { GetTokenUseCaseProtocolMock() }
            .implements(GetTokenUseCaseProtocol.self)
        mock.register { ObserveExpiredTokenUseCaseProtocolMock() }
            .implements(ObserveExpiredTokenUseCaseProtocol.self)
        mock.register { StoreQuestionResponseUseCaseProtocolMock() }
            .implements(StoreQuestionResponseUseCaseProtocol.self)
        mock.register { StoreTokenUseCaseProtocolMock() }
            .implements(StoreTokenUseCaseProtocol.self)
        mock.register { SubmitSurveyResponseUseCaseProtocolMock() }
            .implements(SubmitSurveyResponseUseCaseProtocol.self)
    }
}
