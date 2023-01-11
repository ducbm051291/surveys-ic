//
//  GetSurveyDetailUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class GetSurveyDetailUseCaseSpec: QuickSpec {

    @LazyInjected private var repository: SurveyRepositoryProtocolMock

    override func spec() {

        var useCase: GetSurveyDetailUseCase!

        describe("A GetSurveyDetailUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetSurveyDetailUseCase()
            }

            describe("its execute() call") {

                let surveyToTest = APISurvey.dummy

                context("when surveyRepository emits success") {

                    var executingGetSurveyDetail: Observable<APISurvey>!

                    beforeEach {
                        self.repository.getSurveyDetailIdReturnValue = Just(surveyToTest).asObservable()
                        executingGetSurveyDetail = useCase.execute(id: surveyToTest.id)
                            .compactMap { $0 as? APISurvey }
                            .asObservable()
                    }

                    it("triggers surveyRepository to get survey detail") {
                        _ = try self.awaitPublisher(executingGetSurveyDetail)
                        expect(self.repository.getSurveyDetailIdCalled) == true
                    }

                    it("triggers surveyRepository to get survey detail with correct id") {
                        _ = try self.awaitPublisher(executingGetSurveyDetail)
                        expect(self.repository.getSurveyDetailIdReceivedId) == surveyToTest.id
                    }

                    it("emits correct content value") {
                        let survey = try self.awaitPublisher(executingGetSurveyDetail)
                        expect(survey) == surveyToTest
                    }
                }
            }
        }
    }
}
