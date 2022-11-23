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

            describe("its execute() call") {

                beforeEach {
                    Resolver.registerAllMockServices()
                }

                let email = "email@email.com"
                let password = "password"
                let tokenToTest = APIToken.dummy
                let errorToTest = TestError.mock

                context("when userRepository emits success") {

                    var executingLogin: Observable<APIToken>!

                    beforeEach {
                        self.repository.loginEmailPasswordReturnValue = Just(tokenToTest).asObservable()
                        executingLogin = useCase.execute(email: email, password: password)
                            .compactMap { $0 as? APIToken }
                            .eraseToAnyPublisher()
                    }

                    it("triggers userRepository to login") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordCalled) == true
                    }

                    it("triggers userRepository to login with correct email") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordReceivedArguments?.email) == email
                    }

                    it("triggers userRepository to login with correct password") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordReceivedArguments?.password)
                            .to(equal(password))
                    }

                    it("emits correct content value") {
                        let token = try self.awaitPublisher(executingLogin)
                        expect(token) == tokenToTest
                    }
                }

                context("when userRepository emits failure") {

                    var executingLogin: Observable<APIToken>!

                    beforeEach {
                        self.repository.loginEmailPasswordReturnValue = Fail(
                            outputType: Token.self,
                            failure: errorToTest
                        )
                        .asObservable()
                        executingLogin = useCase.execute(email: email, password: password)
                            .asObservable()
                            .compactMap { $0 as? APIToken }
                            .replaceError(with: .dummy)
                            .asObservable()
                    }

                    it("triggers userRepository to login") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordCalled) == true
                    }

                    it("triggers userRepository to login with correct email") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordReceivedArguments?.email) == email
                    }

                    it("triggers userRepository to login with correct password") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.loginEmailPasswordReceivedArguments?.password)
                            .to(equal(password))
                    }

                    it("emits dummy due to error") {
                        let token = try self.awaitPublisher(executingLogin)
                        expect(token) == .dummy
                    }
                }
            }
        }
    }
}
