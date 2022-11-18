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

final class StoreUserTokenUseCaseSpec: QuickSpec {

    @LazyInjected private var sessionRepository: SessionRepositoryProtocolMock

    override func spec() {

        describe("A StoreUserTokenUseCase") {

            let useCase = StoreTokenUseCase()
            var cancelBag = CancelBag()

            Resolver.registerAllMockServices()

            sessionRepository.saveTokenCallsCount = 0

            describe("its execute() call") {

                let expectation = XCTestExpectation(description: "Save token successfully")
                let tokenToTest = APIToken.dummy

                sessionRepository.saveTokenReturnValue = Just(true).asObservable()
                useCase.execute(token: tokenToTest)
                    .asObservable()
                    .sink { _ in
                    } receiveValue: { success in
                        it("emits correct value") {
                            expect(success) == true
                        }
                        expectation.fulfill()
                    }
                    .store(in: &cancelBag)

                wait(for: [expectation], timeout: 1)
            }
        }
    }
}
