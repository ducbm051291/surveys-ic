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
            }

            describe("its initialize") {

                let pageSize = 10
                let surveysToTest = Array(repeating: APISurvey.dummy, count: pageSize)

                context("when getSurveyListUseCase returns success") {

                    beforeEach {
                        self.getSurveyListUseCase.executePageNumberPageSizeReturnValue = Just(surveysToTest)
                            .asDriver()
                        viewModel = HomeViewModel(bundle: Bundle.main)
                    }

                    it("state changes to loaded") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .loaded
                    }
                }
            }
        }
    }
}
