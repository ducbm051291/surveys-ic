//
//  SessionRepositorySpec.swift
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

final class SessionRepositorySpec: QuickSpec {

    @LazyInjected private var keychain: KeychainProtocolMock

    override func spec() {

        var sessionRepository: SessionRepositoryProtocol!
        var cancelBag = CancelBag()

        Resolver.registerAllMockServices()
        sessionRepository = SessionRepository()

        describe("A SessionRepository") {

            describe("its getToken() call") {

                let expectation = XCTestExpectation(description: "Save token successfully")
                let token = APIToken.dummy

                context("when keychain did saved a token") {
                    try? self.keychain.set(KeychainToken(token), for: .userToken)

                    sessionRepository.getToken()
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { savedToken in
                            it("get correct access token") {
                                expect(savedToken?.accessToken) == token.accessToken
                            }

                            it("get correct refresh token") {
                                expect(savedToken?.refreshToken) == token.refreshToken
                            }

                            it("get correct token type") {
                                expect(savedToken?.tokenType) == token.tokenType
                            }

                            it("get correct expires in") {
                                expect(savedToken?.expiresIn) == token.expiresIn
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }

                context("when keychain didn't save any token") {
                    try? self.keychain.set(KeychainToken(token), for: .userToken)

                    sessionRepository.getToken()
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { savedToken in
                            it("token is nil") {
                                expect(savedToken) == nil
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }
            }

            describe("its saveToken() call") {

                let expectation = XCTestExpectation(description: "Save token successfully")
                let token = APIToken.dummy

                context("when keychain save token successfully") {
                    sessionRepository.saveToken(token)
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { _ in
                            var savedToken: KeychainToken?

                            savedToken = try? self.keychain.get(.userToken)

                            it("saves correct access token") {
                                expect(savedToken?.accessToken) == token.accessToken
                            }

                            it("saves correct refresh token") {
                                expect(savedToken?.refreshToken) == token.refreshToken
                            }

                            it("saves correct token type") {
                                expect(savedToken?.tokenType) == token.tokenType
                            }

                            it("saves correct expires in") {
                                expect(savedToken?.expiresIn) == token.expiresIn
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }
            }

            describe("its hasToken() call") {

                context("when keychain save token successfully") {

                    let expectation = XCTestExpectation(description: "hasToken emit true value")
                    let token = APIToken.dummy

                    try? self.keychain.set(KeychainToken(token), for: .userToken)

                    sessionRepository.hasToken()
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { hasToken in
                            it("hasToken emit correct value") {
                                expect(hasToken) == true
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }

                context("when keychain doesn't save token") {

                    let expectation = XCTestExpectation(description: "hasToken emit false value")
                    try? self.keychain.remove(.userToken)

                    sessionRepository.hasToken()
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { hasToken in
                            it("hasToken emit correct value") {
                                expect(hasToken) == false
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }
            }

            describe("its removeToken() call") {

                context("when keychain contains the token") {

                    let expectation = XCTestExpectation(description: "Remove token successully")
                    let token = APIToken.dummy
                    var savedToken: APIToken?

                    try? self.keychain.set(KeychainToken(token), for: .userToken)

                    sessionRepository.removeToken()
                        .asObservable()
                        .sink { _ in
                        } receiveValue: { success in
                            it("removeToken emit correct value") {
                                expect(success) == true
                            }

                            savedToken = try? self.keychain.get(.userToken)

                            it("Retrive token gets nil value") {
                                expect(savedToken) == nil
                            }
                            expectation.fulfill()
                        }
                        .store(in: &cancelBag)

                    wait(for: [expectation], timeout: 1)
                }
            }
        }
    }
}
