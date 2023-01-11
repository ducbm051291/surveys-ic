//
//  SplashViewModelSpec.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class SplashViewModelSpec: QuickSpec {

    @LazyInjected private var getTokenUseCase: GetTokenUseCaseProtocolMock

    override func spec() {

        describe("A SplashViewModel") {

            var viewModel: SplashViewModel!

            beforeEach {
                Resolver.registerAllMockServices()
            }

            describe("its initialize") {

                context("when the user has already logged in") {

                    beforeEach {
                        self.getTokenUseCase.executeReturnValue = Just(APIToken.dummy).asObservable()
                        viewModel = SplashViewModel()
                    }

                    it("state changes to authenticated") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .authenticated
                    }
                }

                context("when the user has not logged in yet") {

                    beforeEach {
                        self.getTokenUseCase.executeReturnValue = Just(nil).asObservable()
                        viewModel = SplashViewModel()
                    }

                    it("state changes to unauthenticated") {
                        let state = try self.awaitPublisher(viewModel.$state.collectNext(1)).last
                        expect(state) == .unauthenticated
                    }
                }
            }
        }
    }
}
