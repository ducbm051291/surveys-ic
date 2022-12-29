//
//  SurveyViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 29/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class SurveyViewModelSpec: QuickSpec {

    @LazyInjected private var getSurveyDetailUseCase: GetSurveyDetailUseCaseProtocolMock

    override func spec() {

        describe("A SurveyViewModel") {

            var viewModel: SurveyViewModel!
            let surveyToTest = APISurvey.dummy

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = SurveyViewModel(survey: surveyToTest)
            }

            describe("its loadSurveyDetail() called") {

                context("when getSurveyListUseCase returns success") {

                    beforeEach {
                        self.getSurveyDetailUseCase.executeIdReturnValue = Just(surveyToTest)
                            .asObservable()
                        viewModel.loadSurveyDetail()
                    }

                    it("state changes to loading") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .loading
                    }

                    it("state changes to loaded") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                        expect(state) == .loaded
                    }

                    it("surveys updated with surveysToTest") {
                        let survey = try self.awaitPublisher(viewModel.$survey.collectNext(1)).last as? APISurvey
                        expect(survey) == surveyToTest
                    }
                }

                context("when getSurveyListUseCase returns success") {

                    let errorToTest = TestError.mock

                    beforeEach {
                        self.getSurveyDetailUseCase.executeIdReturnValue = Fail(
                            outputType: Survey.self,
                            failure: errorToTest
                        )
                        .asObservable()
                        viewModel.loadSurveyDetail()
                    }

                    it("state changes to loading") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .loading
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
