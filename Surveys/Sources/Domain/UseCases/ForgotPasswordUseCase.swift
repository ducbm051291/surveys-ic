//
//  ForgotPasswordUseCase.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol ForgotPasswordUseCaseProtocol {

    func execute(email: String) -> Observable<APIEmpty>
}

final class ForgotPasswordUseCase: ForgotPasswordUseCaseProtocol {

    @Injected private var authenticationRepository: AuthenticationRepositoryProtocol

    func execute(email: String) -> Observable<APIEmpty> {
        authenticationRepository.forgotPassword(email: email)
    }
}
