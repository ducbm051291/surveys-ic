//
//  LoginViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class LoginViewModelSpec: QuickSpec {

    @LazyInjected private var loginUseCase: LoginUseCaseProtocolMock
    @LazyInjected private var storeTokenUseCase: StoreTokenUseCaseProtocolMock

    override func spec() {

        describe("A LoginViewModel") {

            var viewModel: LoginViewModel!

            beforeEach {
                Resolver.registerAllMockServices()
                viewModel = LoginViewModel()
            }

            describe("its login() call") {

                context("when input fields is valid") {

                    beforeEach {
                        viewModel.email = "email@gmail.com"
                        viewModel.password = "Secret1234@"
                    }

                    context("and loginUseCase returns success") {

                        let tokenToTest = APIToken.dummy
                        let errorToTest = TestError.mock

                        beforeEach {
                            self.loginUseCase.executeEmailPasswordReturnValue = Just(tokenToTest).asObservable()
                        }

                        context("and storeTokenUseCase returns success") {

                            beforeEach {
                                self.storeTokenUseCase.executeTokenReturnValue = Just(true).asObservable()
                                viewModel.logIn()
                            }

                            it("isEmailValid changes to true") {
                                expect(viewModel.isEmailValid) == true
                            }

                            it("isPasswordValid changes to true") {
                                expect(viewModel.isPasswordValid) == true
                            }

                            it("isLoginEnabled changes to true") {
                                expect(viewModel.isLoginEnabled) == true
                            }

                            it("state changes to loading") {
                                let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                                expect(state) == .loading
                            }

                            it("state changes to loggedIn") {
                                let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                                expect(state) == .loggedIn
                            }
                        }

                        context("and storeLoginTokenUseCase returns failure") {

                            beforeEach {
                                self.storeTokenUseCase.executeTokenReturnValue = Fail(
                                    outputType: Bool.self,
                                    failure: errorToTest
                                )
                                .asObservable()
                                viewModel.logIn()
                            }

                            it("isEmailValid changes to true") {
                                expect(viewModel.isEmailValid) == true
                            }

                            it("isPasswordValid changes to true") {
                                expect(viewModel.isPasswordValid) == true
                            }

                            it("isLoginEnabled changes to true") {
                                expect(viewModel.isLoginEnabled) == true
                            }

                            it("state changes to loading") {
                                let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                                expect(state) == .loading
                            }

                            it("state changes to loggedIn") {
                                let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                                expect(state) == .error(Localize.commonErrorText())
                            }
                        }
                    }

                    context("and loginUseCase returns failure") {

                        let errorToTest = TestError.mock

                        beforeEach {
                            self.loginUseCase.executeEmailPasswordReturnValue = Fail(
                                outputType: Token.self,
                                failure: errorToTest
                            )
                            .asObservable()
                            viewModel.logIn()
                        }

                        it("isEmailValid changes to true") {
                            expect(viewModel.isEmailValid) == true
                        }

                        it("isPasswordValid changes to true") {
                            expect(viewModel.isPasswordValid) == true
                        }

                        it("isLoginEnabled changes to true") {
                            expect(viewModel.isLoginEnabled) == true
                        }

                        it("state changes to loading") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                            expect(state) == .loading
                        }

                        it("state changes to loggedIn") {
                            let state = try self.awaitPublisher(viewModel.$state.collectNext(2)).last
                            expect(state) == .error(Localize.commonErrorText())
                        }
                    }
                }

                context("when input fields is invalid") {

                    beforeEach {
                        viewModel.email = "aaaa"
                        viewModel.password = "bbbb"
                    }

                    it("isEmailValid changes to false") {
                        expect(viewModel.isEmailValid) == false
                    }

                    it("isPasswordValid changes to false") {
                        expect(viewModel.isPasswordValid) == false
                    }

                    it("isLoginEnabled changes to false") {
                        expect(viewModel.isLoginEnabled) == false
                    }
                }
            }
        }
    }
}
