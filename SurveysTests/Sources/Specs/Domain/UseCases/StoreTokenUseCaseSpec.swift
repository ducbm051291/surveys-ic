//
//  StoreTokenUseCaseSpec.swift
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

final class StoreTokenUseCaseSpec: QuickSpec {

    @LazyInjected private var sessionRepository: SessionRepositoryProtocolMock

    override func spec() {

        var useCase: StoreTokenUseCase!

        describe("A StoreUserTokenUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = StoreTokenUseCase()
            }

            describe("its execute() call") {

                let tokenToTest = APIToken.dummy

                context("when sessionRepository save token successful") {
                    var executingStoreToken: Observable<Bool>!

                    beforeEach {
                        self.sessionRepository.saveTokenReturnValue = Just(true).asObservable()
                        executingStoreToken = useCase.execute(token: tokenToTest).asObservable()
                    }

                    it("emits correct value") {
                        let success = try self.awaitPublisher(executingStoreToken)
                        expect(success) == true
                    }
                }
            }
        }
    }
}
