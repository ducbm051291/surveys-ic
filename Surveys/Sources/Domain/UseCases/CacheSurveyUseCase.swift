//
//  CacheSurveyUseCase.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol CacheSurveyUseCaseProtocol {

    func execute(_ surveys: [Survey])
}

final class CacheSurveyUseCase: CacheSurveyUseCaseProtocol {

    @Injected private var cachedRepository: CacheRepositoryProtocol

    func execute(_ surveys: [Survey]) {
        cachedRepository.setSurveyList(surveys)
    }
}
