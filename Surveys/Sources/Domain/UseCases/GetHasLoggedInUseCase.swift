//
//  GetAuthenticationStateUseCase.swift
//  Surveys
//
//  Created by David Bui on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

// sourcery: AutoMockable
protocol GetHasLoggedInUseCaseProtocol {

    func execute() -> Observable<Bool>
}

struct GetHasLoggedInUseCase: GetHasLoggedInUseCaseProtocol {

    @Injected private var sessionRepository: SessionRepositoryProtocol

    func execute() -> Observable<Bool> {
        sessionRepository.hasToken()
    }
}
