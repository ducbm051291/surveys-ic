//
//  GetSurveyListUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 20/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class GetSurveyListUseCaseSpec: QuickSpec {

    @LazyInjected private var repository: SurveyRepositoryProtocolMock

    override func spec() {

        var useCase: GetSurveyListUseCase!

        describe("A GetSurveyListUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetSurveyListUseCase()
            }

            describe("its execute() call") {

                let pageNumber = 1
                let pageSize = 10
                let surveysToTest = Array(repeating: APISurvey.dummy, count: pageSize)
                let errorToTest = TestError.mock

                context("when surveyRepository emits success") {

                    var executingGetSurveyList: Observable<[APISurvey]>!

                    beforeEach {
                        self.repository.getSurveyListPageNumberPageSizeReturnValue = Just(surveysToTest).asObservable()
                        executingGetSurveyList = useCase.execute(pageNumber: pageNumber, pageSize: pageSize)
                            .compactMap { $0 as? [APISurvey] }
                            .asObservable()
                    }

                    it("triggers surveyRepository to get survey list") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(self.repository.getSurveyListPageNumberPageSizeCalled) == true
                    }

                    it("triggers surveyRepository to get survey list with correct page number") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(
                            self.repository.getSurveyListPageNumberPageSizeReceivedArguments?.pageNumber
                        ) == pageNumber
                    }

                    it("triggers surveyRepository to get survey list with correct page size") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(self.repository.getSurveyListPageNumberPageSizeReceivedArguments?.pageSize) == pageSize
                    }

                    it("emits correct content value") {
                        let surveys = try self.awaitPublisher(executingGetSurveyList)
                        expect(surveys) == surveysToTest
                    }
                }

                context("when surveyRepository emits failure") {

                    var executingGetSurveyList: Observable<[APISurvey]>!

                    beforeEach {
                        self.repository.getSurveyListPageNumberPageSizeReturnValue = Fail(
                            outputType: [Survey].self,
                            failure: errorToTest
                        )
                        .asObservable()
                        executingGetSurveyList = useCase.execute(pageNumber: pageNumber, pageSize: pageSize)
                            .compactMap { $0 as? [APISurvey] }
                            .replaceError(with: surveysToTest)
                            .asObservable()
                    }

                    it("triggers surveyRepository to get survey list") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(self.repository.getSurveyListPageNumberPageSizeCalled) == true
                    }

                    it("triggers surveyRepository to get survey list with correct page number") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(
                            self.repository.getSurveyListPageNumberPageSizeReceivedArguments?.pageNumber
                        ) == pageNumber
                    }

                    it("triggers surveyRepository to get survey list with correct page size") {
                        _ = try self.awaitPublisher(executingGetSurveyList)
                        expect(self.repository.getSurveyListPageNumberPageSizeReceivedArguments?.pageSize) == pageSize
                    }

                    it("emits dummy due to error") {
                        let token = try self.awaitPublisher(executingGetSurveyList)
                        expect(token) == surveysToTest
                    }
                }
            }
        }
    }
}
