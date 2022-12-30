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

        describe("A ObserveExpiredTokenUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = ObserveExpiredTokenUseCase()
            }

            describe("its execute() call") {

                context("when notification center post unauthenticated notification") {
                    var observeExpiredToken: Observable<Bool>!

                    beforeEach {
                        observeExpiredToken = useCase.execute().map { _ in true }.asObservable()
                        NotificationCenter.default.post(.unauthenticated)
                    }

                    it("emits correct value") {
                        let result = try self.awaitPublisher(observeExpiredToken)
                        expect(result) == true
                    }
                }
            }
        }
    }
}
