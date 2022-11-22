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

            Resolver.registerAllMockServices()

            describe("its execute() call") {

                let email = "email@email.com"
                let password = "password"
                let tokenToTest = APIToken.dummy
                let errorToTest = TestError.mock

                context("when userRepository emits success") {

                    repository.loginEmailPasswordReturnValue = Just(tokenToTest).asObservable()

                    let executingLogin = useCase.execute(email: email, password: password)
                        .asObservable()
                        .compactMap { $0 as? APIToken }

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

                    repository.loginEmailPasswordReturnValue = Fail(
                        outputType: Token.self,
                        failure: errorToTest
                    )
                    .asObservable()
                    let executingLogin = useCase.execute(email: email, password: password)
                        .asObservable()
                        .compactMap { $0 as? APIToken }
                        .replaceError(with: .dummy)

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
