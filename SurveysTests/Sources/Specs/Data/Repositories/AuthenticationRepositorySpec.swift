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

                    networkAPI.setPerformRequestForReturnValue(Just(tokenToTest).asObservable())

                    let login = repository.login(email: email, password: password)
                        .compactMap { $0 as? APIToken }

                    it("triggers networkAPI to performRequest") {
                        _ = try self.awaitPublisher(login)
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        _ = try self.awaitPublisher(login)
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.login(parameter)
                    }

                    it("emits corresponding value") {
                        let token = try self.awaitPublisher(login)
                        expect(token) == tokenToTest
                    }
                }

                context("when networkAPI.performRequest emits failure") {

                    networkAPI.setPerformRequestForReturnValue(
                        Fail(
                            outputType: APIToken.self,
                            failure: errorToTest
                        ).asObservable()
                    )

                    let login = repository.login(email: email, password: password)
                        .compactMap { $0 as? APIToken }
                        .replaceError(with: .dummy)

                    it("triggers networkAPI to performRequest") {
                        expect(networkAPI.performRequestCalled) == true
                    }

                    it("triggers networkAPI to performRequest with correct configuration") {
                        let configuration = networkAPI
                            .performRequestForReceivedArguments?
                            .configuration
                        expect(configuration) == RequestConfiguration.login(parameter)
                    }

                    it("emits dummy due to error") {
                        let token = try self.awaitPublisher(login)
                        expect(token) == .dummy
                    }
                }
            }
        }
    }
}
