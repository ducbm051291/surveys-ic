//
//  LoginUseCase.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol LoginUseCaseProtocol {

    func execute(email: String, password: String) -> Observable<Token>
}

final class LoginUseCase: LoginUseCaseProtocol {

    @Injected private var authenticationRepository: AuthenticationRepositoryProtocol

    func execute(email: String, password: String) -> Observable<Token> {
        authenticationRepository.login(email: email, password: password)
    }
}
