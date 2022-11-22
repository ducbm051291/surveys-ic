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

        Resolver.registerAllMockServices()
        sessionRepository = SessionRepository()

        describe("A SessionRepository") {

            describe("its getToken() call") {

                let tokenToTest = APIToken.dummy

                context("when keychain did saved a token") {
                    try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)

                    let getToken = sessionRepository.getToken()

                    it("get correct access token") {
                        let token = try self.awaitPublisher(getToken)
                        expect(token?.accessToken) == tokenToTest.accessToken
                    }
                }

                context("when keychain didn't save any token") {
                    try? self.keychain.remove(.userToken)

                    let getToken = sessionRepository.getToken()

                    it("get nil token") {
                        let token = try self.awaitPublisher(getToken)
                        expect(token?.accessToken) == nil
                    }
                }
            }

            describe("its saveToken() call") {

                let tokenToTest = APIToken.dummy

                context("when keychain save token successfully") {
                    let saveToken = sessionRepository.saveToken(tokenToTest)

                    it("emit true value") {
                        let success = try self.awaitPublisher(saveToken)
                        expect(success) == true
                    }
                }
            }

            describe("its hasToken() call") {

                context("when keychain save token successfully") {
                    let tokenToTest = APIToken.dummy

                    try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)

                    let hasToken = sessionRepository.hasToken()

                    it("hasToken emit true value") {
                        let result = try self.awaitPublisher(hasToken)
                        expect(result) == true
                    }
                }

                context("when keychain doesn't save token") {
                    try? self.keychain.remove(.userToken)

                    let hasToken = sessionRepository.hasToken()

                    it("hasToken emit false value") {
                        let result = try self.awaitPublisher(hasToken)
                        expect(result) == false
                    }
                }
            }

            describe("its removeToken() call") {

                context("when keychain contains the token") {
                    let tokenToTest = APIToken.dummy

                    try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)

                    let removeToken = sessionRepository.removeToken()

                    it("removeToken emit true value") {
                        let result = try self.awaitPublisher(removeToken)
                        expect(result) == true
                    }
                }
            }
        }
    }
}
