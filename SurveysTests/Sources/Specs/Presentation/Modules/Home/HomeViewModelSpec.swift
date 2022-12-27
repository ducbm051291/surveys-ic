//
//  HomeViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class HomeViewModelSpec: QuickSpec {

    @LazyInjected private var getSurveyListUseCase: GetSurveyListUseCaseProtocolMock

    override func spec() {

        describe("A HomeViewModel") {

            var viewModel: HomeViewModel!

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = HomeViewModel(bundle: Bundle.main)
            }

            describe("its loadSurveys() called") {

                let pageSize = 10
                let surveysToTest = Array(repeating: APISurvey.dummy, count: pageSize)

                context("when getSurveyListUseCase returns success") {

                    beforeEach {
                        self.getSurveyListUseCase.executePageNumberPageSizeReturnValue = Just(surveysToTest)
                            .asObservable()
                        viewModel.loadSurveys()
                    }

                    it("state changes to loaded") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .loaded
                    }

                    it("surveys updated with surveysToTest") {
                        let surveys = try self.awaitPublisher(viewModel.$surveys.collectNext(1)).last as? [APISurvey]
                        expect(surveys) == surveysToTest
                    }
                }
            }
        }
    }
}
