//
//  ClearSurveyCacheUseCase.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol ClearSurveyCacheUseCaseProtocol {

    func execute()
}

final class ClearSurveyCacheUseCase: ClearSurveyCacheUseCaseProtocol {

    @Injected private var cachedRepository: CacheRepositoryProtocol

    func execute() {
        cachedRepository.clearSurveyList()
    }
}
