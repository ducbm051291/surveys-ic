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
                let errorToTest = TestError.mock

                context("when getSurveyListUseCase returns success") {

                    beforeEach {
                        self.getSurveyListUseCase.executePageNumberPageSizeReturnValue = Just(surveysToTest)
                            .asObservable()
                        viewModel = HomeViewModel(bundle: Bundle.main)
                    }

                    it("state changes to loading") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .loading
                    }

                    it("state changes to loaded") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                        expect(state) == .loaded
                    }
                }

                context("when getSurveyListUseCase returns failure") {

                    beforeEach {
                        self.getSurveyListUseCase.executePageNumberPageSizeReturnValue = Fail(
                            outputType: [Survey].self,
                            failure: errorToTest
                        )
                        .asObservable()
                        viewModel = HomeViewModel(bundle: Bundle.main)
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
