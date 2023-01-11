//
//  ObserveExpiredTokenUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 30/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class ObserveExpiredTokenUseCaseSpec: QuickSpec {

    override func spec() {

        var useCase: ObserveExpiredTokenUseCase!
        var cancelBag: CancelBag!

        describe("A ObserveExpiredTokenUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = ObserveExpiredTokenUseCase()
                cancelBag = CancelBag()
            }

            describe("its execute() call") {

                context("when notification center post unauthenticated notification") {

                    it("emits correct value") {
                        useCase.execute().map { _ in true }
                            .sink { _ in
                            } receiveValue: { expiredToken in
                                expect(expiredToken) == true
                            }
                            .store(in: &cancelBag)
                        NotificationCenter.default.post(.unauthenticated)
                    }
                }
            }
        }
    }
}
