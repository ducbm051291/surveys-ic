//
//  GetTokenUseCase.swift
//  Surveys
//
//  Created by David Bui on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

// sourcery: AutoMockable
protocol GetTokenUseCaseProtocol {

    func execute() -> Observable<Token?>
}

struct GetTokenUseCase: GetTokenUseCaseProtocol {

    @Injected private var sessionRepository: SessionRepositoryProtocol

    func execute() -> Observable<Token?> {
        sessionRepository.getToken()
    }
}
