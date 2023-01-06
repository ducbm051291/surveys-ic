//
//  SurveyResponseRepositorySpec.swift
//  Surveys
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class SurveyResponseRepositorySpec: QuickSpec {

    override func spec() {

        var networkAPI: NetworkAPIProtocolMock!
        var repository: SurveyResponseRepositoryProtocol!

        describe("A SurveyResponseRepository") {

            beforeEach {
                Resolver.registerAllMockServices()
                repository = SurveyResponseRepository()
                networkAPI = Resolver.resolve(NetworkAPIProtocol.self, name: .jsonNetworkAPI) as? NetworkAPIProtocolMock
            }

            describe("its submitResponse() call") {

                let surveyToTest = APISurvey.dummy
                let parameterToTest = SurveyResponseParameter(
                    surveyId: surveyToTest.id,
                    questions: []
                )
                let errorToTest = TestError.mock

                context("when networkAPI emits success from performRequest") {

                    var submitResponse: Observable<Void>!

                    beforeEach {
                        networkAPI.setPerformRequestForReturnValue(Just(APINoReply()).asObservable())
                        submitResponse = repository.submitResponse(surveyToTest)
                            .asObservable()
                    }

                    it("triggers networkAPI to performRequest") {
                        _ = try self.awaitPublisher(submitResponse)
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        _ = try self.awaitPublisher(submitResponse)
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.surveyResponse(parameterToTest)
                    }

                    it("emits corresponding value") {
                        let result: Void = try self.awaitPublisher(submitResponse)
                        expect(result) != nil
                    }
                }

                context("when networkAPI emits failure from performRequest") {

                    var submitResponse: Observable<Void>!

                    beforeEach {
                        networkAPI.setPerformRequestForReturnValue(
                            Fail(
                                outputType: APINoReply.self,
                                failure: errorToTest
                            ).asObservable()
                        )
                        submitResponse = repository.submitResponse(surveyToTest)
                            .replaceError(with: ())
                            .asObservable()
                    }

                    it("triggers networkAPI to performRequest") {
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        _ = try self.awaitPublisher(submitResponse)
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.surveyResponse(parameterToTest)
                    }

                    it("emits corresponding value") {
                        let result: Void = try self.awaitPublisher(submitResponse)
                        expect(result) != nil
                    }
                }
            }
        }
    }
}
