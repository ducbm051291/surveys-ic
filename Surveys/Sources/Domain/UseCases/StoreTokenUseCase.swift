//
//  StoreTokenUseCase.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

protocol StoreTokenUseCaseProtocol {

    func execute(token: Token) -> Observable<Bool>
}

struct StoreTokenUseCase: StoreTokenUseCaseProtocol {

    @Injected private var sessionRepository: SessionRepositoryProtocol

    func execute(token: Token) -> Observable<Bool> {
        sessionRepository.saveToken(token)
    }
}
