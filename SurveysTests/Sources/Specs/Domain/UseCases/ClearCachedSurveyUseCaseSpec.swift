//
//  ClearCachedSurveyUseCaseSpec.swift
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

final class ClearCachedSurveyUseCaseSpec: QuickSpec {

    @LazyInjected private var cacheRepository: CacheRepositoryProtocolMock

    override func spec() {

        var useCase: ClearCachedSurveyUseCase!

        describe("A CacheSurveyUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = ClearCachedSurveyUseCase()
            }

            describe("its execute() call") {

                beforeEach {
                    useCase.execute()
                }

                it("triggers cacheRepository to cache surveys") {
                    expect(self.cacheRepository.clearSurveyListCalled) == true
                }
            }
        }
    }
}
