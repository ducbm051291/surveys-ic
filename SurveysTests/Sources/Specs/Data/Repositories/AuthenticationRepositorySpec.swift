//
//  AuthenticationRepositorySpec.swift
//  Surveys
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
        var cancelBag: CancelBag!

        Resolver.registerAllMockServices()
        cancelBag = CancelBag()
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

                context("when networkAPI.performRequest emits success") {

                    let expectation = XCTestExpectation(description: "Emit correct token")

                    networkAPI.setPerformRequestForReturnValue(Just(tokenToTest).asObservable())
                    repository.login(email: email, password: password)
                        .compactMap { $0 as? APIToken }
                        .sink(receiveCompletion: { _ in
                        }, receiveValue: { token in
                            it("triggers networkAPI to performRequest") {
                                expect(networkAPI.performRequestCalled) == true
                            }

                            it("emits corresponding value") {
                                expect(token) == tokenToTest
                            }
                            expectation.fulfill()
                        })
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }

                context("when networkAPI.performRequest emits failure") {

//                    var output: TestableObserver<Error>!
//
//                    beforeEach {
//                        output = scheduler.createObserver(Error.self)
//                        networkAPI
//                            .setPerformRequestForReturnValue(
//                                Single<(APIToken, LoginMeta)>.error(TestError.mock),
//                                for: LoginResponse.self
//                            )
//                        repository.login(email: email, password: password)
//                            .asObservable()
//                            .materialize()
//                            .compactMap { $0.error }
//                            .bind(to: output)
//                            .disposed(by: disposeBag)
//                    }
//
//                    it("triggers networkAPI to performRequest") {
//                        expect(networkAPI.performRequestForCalled).to(beTrue())
//                    }
//
//                    it("triggers networkAPI to performRequest with correct configuration") {
//                        let configuration = networkAPI
//                            .performRequestForReceivedArguments?
//                            .configuration as? AuthRequestConfiguration
//                        expect(configuration).to(equal(.login("email@email.com", "password")))
//                    }
//
//                    it("emits corresponding error") {
//                        let error = output.events.first?.value.element as? TestError
//                        expect(error) == TestError.mock
//                    }
                }
            }
        }
    }
}
