//
//  CacheSurveyUseCaseSpec.swift
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

final class CacheSurveyUseCaseSpec: QuickSpec {

    @LazyInjected private var cacheRepository: CacheRepositoryProtocolMock

    override func spec() {

        var useCase: CacheSurveyUseCase!

        describe("A CacheSurveyUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = CacheSurveyUseCase()
            }

            describe("its execute() call") {

                let surveysToTest = Array(repeating: APISurvey.dummy, count: 10)

                context("when cacheRepository caches surveys successful") {

                    beforeEach {
                        useCase.execute(surveysToTest)
                    }

                    it("triggers cacheRepository to cache surveys") {
                        expect(self.cacheRepository.setSurveyListCalled) == true
                    }
                }
            }

            afterEach {
                Resolver.reset()
            }
        }
    }
}
