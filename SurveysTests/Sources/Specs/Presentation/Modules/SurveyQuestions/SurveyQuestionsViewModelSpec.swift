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

                beforeEach {
                    self.submitSurveyResponseUseCase.executeSurveyIdQuestionsReturnValue = Just(()).asObservable()
                    viewModel.submitQuestionResponse()
                }

                it("triggers submitSurveyResponseUseCase to execute") {
                    expect(self.submitSurveyResponseUseCase.executeSurveyIdQuestionsCalled) == true
                }

                it("state changes to submitted") {
                    let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                    expect(state) == .submitted
                }
            }
        }
    }
}
