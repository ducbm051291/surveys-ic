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

        describe("A StoreUserTokenUseCase") {

            let useCase = StoreTokenUseCase()

            describe("its execute() call") {
                let tokenToTest = APIToken.dummy

                sessionRepository.saveTokenReturnValue = Just(true).asObservable()

                it("emits correct value") {
                    let result = try self.awaitPublisher(useCase.execute(token: tokenToTest))
                    expect(result) == true
                }
            }
        }
    }
}
