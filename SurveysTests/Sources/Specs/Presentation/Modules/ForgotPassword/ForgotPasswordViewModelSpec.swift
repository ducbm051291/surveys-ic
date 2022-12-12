//
//  ForgotPasswordViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 06/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class ForgotPasswordViewModelSpec: QuickSpec {

    @LazyInjected private var forgotPasswordUseCase: ForgotPasswordUseCaseProtocolMock

    override func spec() {

        describe("A ForgotPasswordViewModel") {

            var viewModel: ForgotPasswordViewModel!

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = ForgotPasswordViewModel(email: .empty)
            }

            describe("its login() call") {

                context("when input fields is valid") {

                    beforeEach {
                        viewModel.email = "email@gmail.com"
                    }

                    context("and forgotPasswordUseCase returns success") {

                        let messageToTest = APIMessage.dummy

                        beforeEach {
                            self.forgotPasswordUseCase.executeEmailReturnValue = Just(messageToTest).asObservable()
                            viewModel.resetPassword()
                        }

                        it("isResetEnabled changes to true") {
                            expect(viewModel.isResetEnabled) == true
                        }

                        it("state changes to loading") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                            expect(state) == .loading
                        }

                        it("state changes to reset") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                            expect(state) == .didReset(messageToTest.message)
                        }
                    }

                    context("and forgotPasswordUseCase returns failure") {

                        let errorToTest = TestError.mock

                        beforeEach {
                            self.forgotPasswordUseCase.executeEmailReturnValue = Fail(
                                outputType: Message.self,
                                failure: errorToTest
                            )
                            .asObservable()
                            viewModel.resetPassword()
                        }

                        it("isResetEnabled changes to true") {
                            expect(viewModel.isResetEnabled) == true
                        }

                        it("state changes to loading") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                            expect(state) == .loading
                        }

                        it("state changes to error with common error text") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                            expect(state) == .error(Localize.commonErrorText())
                        }
                    }
                }
            }
        }
    }
}
