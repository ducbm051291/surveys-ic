//
//  SurveyAnswerViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 03/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

class SurveyAnswerViewModelSpec: QuickSpec {

    @LazyInjected private var storeQuestionResponseUseCase: StoreQuestionResponseUseCaseProtocolMock

    override func spec() {

        describe("A SurveyAnswerViewModel") {

            var viewModel: SurveyAnswerViewModel!
            let questionToTest = APISurvey.APIQuestion.dummyList.first!

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = SurveyAnswerViewModel(question: questionToTest)
            }

            context("when answering a question") {

                beforeEach {
                    viewModel.answer(0)
                }

                it("should store the answer response") {
                    expect(self.storeQuestionResponseUseCase.executeQuestionResponseCalled).to(beTrue())
                }
            }
        }
    }
}
