//
//  GetHasLoggedInUseCaseSpec.swift
//  Surveys
//
//  Created by David Bui on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class GetHasLoggedInUseCaseSpec: QuickSpec {

    @LazyInjected private var sessionRepository: SessionRepositoryProtocolMock

    override func spec() {

        var useCase: GetHasLoggedInUseCase!

        describe("A GetHasLoggedInUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetHasLoggedInUseCase()
            }

            describe("its execute() call") {

                context("when sessionRepository.hasToken return true") {
                    var executingHasLoggedIn: Observable<Bool>!

                    beforeEach {
                        self.sessionRepository.hasTokenReturnValue = Just(true).asObservable()
                        executingHasLoggedIn = useCase.execute().asObservable()
                    }

                    it("emits correct value") {
                        let savedToken = try self.awaitPublisher(executingHasLoggedIn)
                        expect(savedToken) == true
                    }
                }

                context("when sessionRepository.hasToken return false") {
                    var executingHasLoggedIn: Observable<Bool>!

                    beforeEach {
                        self.sessionRepository.hasTokenReturnValue = Just(false).asObservable()
                        executingHasLoggedIn = useCase.execute().asObservable()
                    }

                    it("emits correct value") {
                        let savedToken = try self.awaitPublisher(executingHasLoggedIn)
                        expect(savedToken) == false
                    }
                }
            }
        }
    }
}
