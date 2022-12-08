//
//  ForgotPasswordUseCaseSpec.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class ForgotPasswordUseCaseSpec: QuickSpec {

    @LazyInjected private var repository: AuthenticationRepositoryProtocolMock

    override func spec() {

        var useCase: ForgotPasswordUseCase!

        describe("A ForgotPasswordUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = ForgotPasswordUseCase()
            }

            describe("its execute() call") {

                let email = "email@email.com"
                let messageToTest = APIMessage.dummy
                let errorToTest = TestError.mock

                context("when authenticationRepository emits success") {

                    var executingLogin: Observable<APIMessage>!

                    beforeEach {
                        self.repository.forgotPasswordEmailReturnValue = Just(messageToTest).asObservable()
                        executingLogin = useCase.execute(email: email)
                            .compactMap { $0 as? APIMessage }
                            .asObservable()
                    }

                    it("triggers authenticationRepository to login") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.forgotPasswordEmailCalled) == true
                    }

                    it("triggers authenticationRepository to login with correct email") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.forgotPasswordEmailReceivedEmail) == email
                    }

                    it("emits correct content value") {
                        let result = try self.awaitPublisher(executingLogin)
                        expect(result) == messageToTest
                    }
                }

                context("when authenticationRepository emits failure") {

                    var executingLogin: Observable<APIMessage>!

                    beforeEach {
                        self.repository.loginEmailPasswordReturnValue = Fail(
                            outputType: Token.self,
                            failure: errorToTest
                        )
                        .asObservable()
                        executingLogin = useCase.execute(email: email)
                            .compactMap { $0 as? APIMessage }
                            .replaceError(with: messageToTest)
                            .asObservable()
                    }

                    it("triggers authenticationRepository to login") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.forgotPasswordEmailCalled) == true
                    }

                    it("triggers authenticationRepository to login with correct email") {
                        _ = try self.awaitPublisher(executingLogin)
                        expect(self.repository.forgotPasswordEmailReceivedEmail) == email
                    }

                    it("emits dummy due to error") {
                        let result = try self.awaitPublisher(executingLogin)
                        expect(result) == messageToTest
                    }
                }
            }
        }
    }
}
