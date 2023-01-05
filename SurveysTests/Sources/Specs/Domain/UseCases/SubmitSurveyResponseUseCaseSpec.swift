//
//  SubmitSurveyResponseUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class SubmitSurveyResponseUseCaseSpec: QuickSpec {

    @LazyInjected private var repository: SurveyResponseRepositoryProtocolMock

    override func spec() {

        var useCase: SubmitSurveyResponseUseCase!

        describe("A SubmitSurveyResponseUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = SubmitSurveyResponseUseCase()
            }

            describe("its execute() call") {

                let surveysToTest = APISurvey.dummy

                context("when surveyResponseRepository emits success") {

                    var executingSubmitSurveyResponse: Observable<Void>!

                    beforeEach {
                        self.repository.submitResponseReturnValue = Just(()).asObservable()
                        executingSubmitSurveyResponse = useCase.execute(survey: surveysToTest)
                            .asObservable()
                    }

                    it("triggers surveyRepository to get survey list") {
                        _ = try self.awaitPublisher(executingSubmitSurveyResponse)
                        expect(self.repository.submitResponseCalled) == true
                    }

                    it("triggers surveyRepository to get survey list with correct page number") {
                        _ = try self.awaitPublisher(executingSubmitSurveyResponse)
                        expect(self.repository.submitResponseReceivedSurvey?.id) == surveysToTest.id
                    }

                    it("emits correct content value") {
                        let result: Void = try self.awaitPublisher(executingSubmitSurveyResponse)
                        expect(result) != nil
                    }
                }
            }
        }
    }
}
