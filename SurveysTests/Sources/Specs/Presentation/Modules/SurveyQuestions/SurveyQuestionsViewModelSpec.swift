//
//  SurveyQuestionsViewModelSpec.swift
//  SurveysTests
//
//  Created by David Bui on 02/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class SurveyQuestionsViewModelSpec: QuickSpec {

    @LazyInjected private var submitSurveyResponseUseCase: SubmitSurveyResponseUseCaseProtocolMock
    @LazyInjected private var getQuestionResponseUseCase: GetQuestionResponseUseCaseProtocolMock
    @LazyInjected private var clearQuestionResponseUseCase: ClearQuestionResponseUseCaseProtocolMock

    override func spec() {

        describe("A SurveyQuestionsViewModelSpec") {

            var viewModel: SurveyQuestionsViewModel!
            let surveyToTest = APISurvey.dummy
            let errorToTest = TestError.mock

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = SurveyQuestionsViewModel(survey: surveyToTest)
            }

            describe("its clearQuestionResponse() called") {

                beforeEach {
                    viewModel.clearQuestionResponse()
                }

                it("triggers clearQuestionResponseUseCase to execute") {
                    expect(self.clearQuestionResponseUseCase.executeIdCalled) == true
                }
            }

            describe("its submitQuestionResponse() called") {

                context("and submitSurveyResponseUseCase returns success") {

                    beforeEach {
                        self.submitSurveyResponseUseCase.executeSurveyIdQuestionsReturnValue = Just(()).asObservable()
                        viewModel.submitQuestionResponse()
                    }

                    it("triggers submitSurveyResponseUseCase to execute") {
                        expect(self.submitSurveyResponseUseCase.executeSurveyIdQuestionsCalled) == true
                    }

                    it("state changes to loading") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .submitting
                    }

                    it("state changes to submitted") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                        expect(state) == .submitted
                    }
                }

                context("and submitSurveyResponseUseCase returns failure") {

                    beforeEach {
                        self.submitSurveyResponseUseCase.executeSurveyIdQuestionsReturnValue = Fail(
                            outputType: Void.self,
                            failure: errorToTest
                        )
                        .asObservable()
                        viewModel.submitQuestionResponse()
                    }

                    it("triggers submitSurveyResponseUseCase to execute") {
                        expect(self.submitSurveyResponseUseCase.executeSurveyIdQuestionsCalled) == true
                    }

                    it("state changes to loading") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .submitting
                    }

                    it("state changes to error with common error text") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                        expect(state) == .error(Localize.commonErrorText())
                    }
                }
            }
        }
    }
}
