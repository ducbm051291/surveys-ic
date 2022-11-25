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

        describe("A SessionRepository") {

            beforeEach {
                Resolver.registerAllMockServices()
                sessionRepository = SessionRepository()
            }

            describe("its getToken() call") {

                let tokenToTest = APIToken.dummy

                context("when keychain did save a token") {

                    var getToken: Observable<Token?>!

                    beforeEach {
                        try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)

                        getToken = sessionRepository.getToken().asObservable()
                    }

                    it("gets correct access token") {
                        let token = try self.awaitPublisher(getToken)
                        expect(token?.accessToken) == tokenToTest.accessToken
                    }
                }

                context("when keychain didn't save any token") {

                    var getToken: Observable<Token?>!

                    beforeEach {
                        try? self.keychain.remove(.userToken)

                        getToken = sessionRepository.getToken().asObservable()
                    }

                    it("gets nil token") {
                        let token = try self.awaitPublisher(getToken)
                        expect(token?.accessToken) == nil
                    }
                }
            }

            describe("its saveToken() call") {

                let tokenToTest = APIToken.dummy

                context("when keychain save token successfully") {
                    var saveToken: Observable<Bool>!

                    beforeEach {
                        saveToken = sessionRepository.saveToken(tokenToTest).asObservable()
                    }

                    it("emits true value") {
                        let success = try self.awaitPublisher(saveToken)
                        expect(success) == true
                    }
                }
            }

            describe("its hasToken() call") {

                context("when keychain save token successfully") {
                    let tokenToTest = APIToken.dummy

                    var hasToken: Observable<Bool>!

                    beforeEach {
                        try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)
                        hasToken = sessionRepository.hasToken().asObservable()
                    }

                    it("hasToken emits true value") {
                        let result = try self.awaitPublisher(hasToken)
                        expect(result) == true
                    }
                }

                context("when keychain doesn't save token") {
                    var hasToken: Observable<Bool>!

                    beforeEach {
                        try? self.keychain.remove(.userToken)
                        hasToken = sessionRepository.hasToken().asObservable()
                    }

                    it("hasToken emits false value") {
                        let result = try self.awaitPublisher(hasToken)
                        expect(result) == false
                    }
                }
            }

            describe("its removeToken() call") {

                context("when keychain contains the token") {
                    let tokenToTest = APIToken.dummy
                    var removeToken: Observable<Bool>!

                    beforeEach {
                        try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)
                        removeToken = sessionRepository.removeToken().asObservable()
                    }

                    it("removeToken emits true value") {
                        let result = try self.awaitPublisher(removeToken)
                        expect(result) == true
                    }
                }
            }
        }
    }
}
