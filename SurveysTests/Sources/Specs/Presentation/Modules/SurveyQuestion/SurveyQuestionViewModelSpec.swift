//
//  SurveyQuestionViewModelSpec.swift
//  SurveysTests
//
//  Created by David Bui on 03/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

class SurveyQuestionViewModelTests: QuickSpec {

    override func spec() {

        describe("A SurveyQuestionViewModel") {

            var viewModel: SurveyQuestionViewModel!
            let questionToTest = APISurvey.APIQuestion.dummyList.first!

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = SurveyQuestionViewModel(question: questionToTest, numberOfQuestion: 2)
            }

            it("sets the correct question") {
                expect(viewModel.question.id) == questionToTest.id
            }

            it("sets the correct question index") {
                expect(viewModel.questionIndex) == "1/2"
            }

            it("sets the correct question text") {
                expect(viewModel.questionText) == "Food â€“ Variety, Taste and Presentation"
            }
        }
    }
}
