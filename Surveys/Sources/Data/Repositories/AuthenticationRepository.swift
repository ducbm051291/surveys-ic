//
//  AuthenticationRepository.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class AuthenticationRepository: AuthenticationRepositoryProtocol {

    @Injected private var networkAPI: NetworkAPIProtocol

    func forgotPassword(email: String) -> Observable<Message> {
        let parameter = ForgotPasswordParameter(
            user: UserParameter(email: email),
            clientId: Constants.API.clientId,
            clientSecret: Constants.API.clientSecret
        )
        return networkAPI.performRequest(.forgotPassword(parameter), for: APIMessage.self)
            .map { $0 as Message }
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> Observable<Token> {
        let parameter = LoginParameter(
            grantType: Constants.GrantType.password.rawValue,
            email: email,
            password: password,
            clientId: Constants.API.clientId,
            clientSecret: Constants.API.clientSecret
        )
        return networkAPI.performRequest(.login(parameter), for: APIToken.self)
            .map { $0 as Token }
            .eraseToAnyPublisher()
    }
}
