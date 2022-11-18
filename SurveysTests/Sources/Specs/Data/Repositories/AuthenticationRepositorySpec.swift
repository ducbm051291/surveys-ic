//
//  AuthenticationRepositorySpec.swift
//  SurveysTests
//
//  Created by David Bui on 18/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class AuthenticationRepositorySpec: QuickSpec {

    override func spec() {

        var networkAPI: NetworkAPIProtocolMock!
        var repository: AuthenticationRepositoryProtocol!
        var cancelBag = CancelBag()

        Resolver.registerAllMockServices()
        repository = AuthenticationRepository()
        networkAPI = Resolver.resolve(
            NetworkAPIProtocol.self,
            name: .defaultNetworkAPI
        ) as? NetworkAPIProtocolMock

        describe("An AuthenticationRepository") {

            describe("its login() call") {

                let email = "email@email.com"
                let password = "password"
                let tokenToTest = APIToken.dummy
                let errorToTest = TestError.mock
                let parameter = LoginParameter(
                    grantType: Constants.GrantType.password.rawValue,
                    email: email,
                    password: password,
                    clientId: Constants.API.clientId,
                    clientSecret: Constants.API.clientSecret
                )

                context("when networkAPI.performRequest emits success") {

                    let expectation = XCTestExpectation(description: "Emit correct token")

                    networkAPI.setPerformRequestForReturnValue(Just(tokenToTest).asObservable())
                    repository.login(email: email, password: password)
                        .compactMap { $0 as? APIToken }
                        .sink { _ in
                        } receiveValue: { token in
                            it("triggers networkAPI to performRequest") {
                                expect(networkAPI.performRequestCalled) == true
                            }

                            it("triggers networkAPI to performRequest with correct configuration") {
                                let configuration = networkAPI
                                    .performRequestForReceivedArguments?
                                    .configuration
                                expect(configuration) == RequestConfiguration.login(parameter)
                            }

                            it("emits corresponding value") {
                                expect(token) == tokenToTest
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }

                context("when networkAPI.performRequest emits failure") {

                    let expectation = XCTestExpectation(description: "Emit error")

                    networkAPI.setPerformRequestForReturnValue(
                        Fail(
                            outputType: APIToken.self,
                            failure: errorToTest
                        ).asObservable()
                    )
                    repository.login(email: email, password: password)
                        .compactMap { $0 as? APIToken }
                        .sink { completion in
                            it("triggers networkAPI to performRequest") {
                                expect(networkAPI.performRequestCalled) == true
                            }

                            it("triggers networkAPI to performRequest with correct configuration") {
                                let configuration = networkAPI
                                    .performRequestForReceivedArguments?
                                    .configuration
                                expect(configuration) == RequestConfiguration.login(parameter)
                            }

                            it("emits error") {
                                switch completion {
                                case .failure:
                                    expectation.fulfill()
                                default:
                                    break
                                }
                            }
                        } receiveValue: { _ in
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }
            }
        }
    }
}
