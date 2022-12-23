//
//  GetCachedSurveyUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class GetCachedSurveyUseCaseSpec: QuickSpec {

    @LazyInjected private var cacheRepository: CacheRepositoryProtocolMock

    override func spec() {

        var useCase: GetCachedSurveyUseCase!

        describe("A GetCachedSurveyUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetCachedSurveyUseCase()
            }

            describe("its execute() call") {

                let surveysToTest = Array(repeating: APISurvey.dummy, count: 10)
                var result: [APISurvey] = []

                beforeEach {
                    self.cacheRepository.getSurveyListReturnValue = surveysToTest
                    result = useCase.execute() as? [APISurvey] ?? []
                }

                it("triggers cacheRepository to cache surveys") {
                    expect(self.cacheRepository.clearSurveyListCalled) == true
                }

                it("returns correct cache surveys") {
                    expect(result) == surveysToTest
                }
            }
        }
    }
}
