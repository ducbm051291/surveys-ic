//
//  GetCachedSurveyUseCase.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol GetCachedSurveyUseCaseProtocol {

    func execute() -> Observable<[Survey]>
}

final class GetCachedSurveyUseCase: GetCachedSurveyUseCaseProtocol {

    @Injected private var cachedRepository: CachedRepositoryProtocol

    func execute() -> Observable<[Survey]> {
        cachedRepository.getSurveyList()
    }
}
