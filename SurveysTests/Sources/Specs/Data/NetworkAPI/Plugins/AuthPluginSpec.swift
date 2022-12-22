//
//  AuthPluginSpec.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class AuthPluginSpec: QuickSpec {

    @LazyInjected private var keychain: KeychainProtocolMock

    override func spec() {

        var authPlugin: AuthPlugin!

        describe("An AuthPlugin") {

            beforeEach {
                Resolver.registerAllMockServices()
                authPlugin = AuthPlugin()
            }

            describe("its prepare() call") {

                let requestConfigurationToTest = RequestConfiguration.surveyList(1, 10)
                let tokenToTest = APIToken.dummy
                let authorizationToTest = "\(tokenToTest.tokenType) \(tokenToTest.accessToken)"
                let requestToTest = URLRequest(url: requestConfigurationToTest.baseURL)

                context("when the user did authenticate") {

                    beforeEach {
                        try? self.keychain.set(KeychainToken(tokenToTest), for: .userToken)
                    }

                    it("request header contains authorization data") {
                        let request = authPlugin.prepare(requestToTest, target: RequestConfiguration.surveyList(1, 10))
                        expect(request.headers.value(for: "Authorization")) == authorizationToTest
                    }
                }

                context("when the user did not authenticate") {

                    beforeEach {
                        try? self.keychain.remove(.userToken)
                    }

                    it("request header contains authorization data") {
                        let request = authPlugin.prepare(requestToTest, target: RequestConfiguration.surveyList(1, 10))
                        expect(request.headers.value(for: "Authorization")) == nil
                    }
                }
            }
        }
    }
}
