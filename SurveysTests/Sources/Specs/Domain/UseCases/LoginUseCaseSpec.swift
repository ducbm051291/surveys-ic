//
//  LoginUseCaseSpec.swift
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

final class LoginUseCaseSpec: QuickSpec {

    @LazyInjected private var repository: AuthenticationRepositoryProtocolMock

    override func spec() {

        describe("A LoginUseCase") {

            let useCase = LoginUseCase()
            var cancelBag = CancelBag()

            Resolver.registerAllMockServices()

            describe("its execute() call") {

                let email = "email@email.com"
                let password = "password"
                let tokenToTest = APIToken.dummy
                let errorToTest = TestError.mock

                context("when userRepository emits success") {

                    let expectation = XCTestExpectation(description: "Emit correct token")

                    repository.loginEmailPasswordReturnValue = Just(tokenToTest).asObservable()
                    useCase.execute(email: email, password: password)
                        .asObservable()
                        .compactMap { $0 as? APIToken }
                        .sink { _ in
                        } receiveValue: { token in
                            it("triggers userRepository to login") {
                                expect(self.repository.loginEmailPasswordCalled) == true
                            }

                            it("triggers userRepository to login with correct email") {
                                expect(self.repository.loginEmailPasswordReceivedArguments?.email) == email
                            }

                            it("triggers userRepository to login with correct password") {
                                expect(self.repository.loginEmailPasswordReceivedArguments?.password)
                                    .to(equal(password))
                            }

                            it("emits correct content value") {
                                expect(token) == tokenToTest
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }

                context("when userRepository emits failure") {

                    let expectation = XCTestExpectation(description: "Emit error")

                    repository.loginEmailPasswordReturnValue = Fail(
                        outputType: Token.self,
                        failure: errorToTest
                    )
                    .asObservable()
                    useCase.execute(email: email, password: password)
                        .asObservable()
                        .compactMap { $0 as? APIToken }
                        .sink { completion in
                            it("triggers userRepository to login") {
                                expect(self.repository.loginEmailPasswordCalled) == true
                            }

                            it("triggers userRepository to login with correct email") {
                                expect(self.repository.loginEmailPasswordReceivedArguments?.email) == email
                            }

                            it("triggers userRepository to login with correct password") {
                                expect(self.repository.loginEmailPasswordReceivedArguments?.password)
                                    .to(equal(password))
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
