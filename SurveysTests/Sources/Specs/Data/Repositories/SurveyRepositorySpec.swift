//
//  SurveyRepositorySpec.swift
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

final class SurveyRepositorySpec: QuickSpec {

    override func spec() {

        var networkAPI: NetworkAPIProtocolMock!
        var repository: SurveyRepositoryProtocol!

        describe("An SurveyRepository") {

            beforeEach {
                Resolver.registerAllMockServices()
                repository = SurveyRepository()
                networkAPI = Resolver.resolve(NetworkAPIProtocol.self) as? NetworkAPIProtocolMock
            }

            describe("its getSurveyList() call") {

                let pageNumber = 1
                let pageSize = 10
                let surveysToTest = Array(repeating: APISurvey.dummy, count: pageSize)
                let errorToTest = TestError.mock

                context("when networkAPI emits success from performRequest") {

                    var getSurveyList: Observable<[APISurvey]>!

                    beforeEach {
                        networkAPI.setPerformRequestForReturnValue(Just(surveysToTest).asObservable())
                        getSurveyList = repository.getSurveyList(pageNumber: pageNumber, pageSize: pageSize)
                            .compactMap { $0 as? [APISurvey] }
                            .asObservable()
                    }

                    it("triggers networkAPI to performRequest") {
                        _ = try self.awaitPublisher(getSurveyList)
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        _ = try self.awaitPublisher(getSurveyList)
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.surveyList(pageNumber, pageSize)
                    }

                    it("emits corresponding value") {
                        let result = try self.awaitPublisher(getSurveyList)
                        expect(result) == surveysToTest
                    }
                }

                context("when networkAPI emits failure from performRequest") {

                    var getSurveyList: Observable<[APISurvey]>!

                    beforeEach {
                        networkAPI.setPerformRequestForReturnValue(
                            Fail(
                                outputType: [APISurvey].self,
                                failure: errorToTest
                            ).asObservable()
                        )
                        getSurveyList = repository.getSurveyList(pageNumber: pageNumber, pageSize: pageSize)
                            .compactMap { $0 as? [APISurvey] }
                            .replaceError(with: surveysToTest)
                            .asObservable()
                    }

                    it("triggers networkAPI to performRequest") {
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        _ = try self.awaitPublisher(getSurveyList)
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.surveyList(pageNumber, pageSize)
                    }

                    it("emits corresponding value") {
                        let result = try self.awaitPublisher(getSurveyList)
                        expect(result) == surveysToTest
                    }
                }
            }
        }
    }
}
