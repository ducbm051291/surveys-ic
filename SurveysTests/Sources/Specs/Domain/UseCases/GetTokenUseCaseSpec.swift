//
//  GetTokenUseCaseSpec.swift
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

final class GetTokenUseCaseSpec: QuickSpec {

    @LazyInjected private var sessionRepository: SessionRepositoryProtocolMock

    override func spec() {

        var useCase: GetTokenUseCase!

        describe("A GetTokenUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetTokenUseCase()
            }

            describe("its execute() call") {

                let tokenToTest = APIToken.dummy

                context("when sessionRepository get token successful") {
                    var executingGetToken: Observable<APIToken?>!

                    beforeEach {
                        self.sessionRepository.getTokenReturnValue = Just(tokenToTest).asObservable()
                        executingGetToken = useCase.execute()
                            .compactMap { $0 as? APIToken }
                            .asObservable()
                    }

                    it("emits correct value") {
                        let savedToken = try self.awaitPublisher(executingGetToken)
                        expect(savedToken) == tokenToTest
                    }
                }

                context("when sessionRepository failed to get token") {
                    var executingGetToken: Observable<APIToken?>!

                    beforeEach {
                        self.sessionRepository.getTokenReturnValue = Just(nil).asObservable()
                        executingGetToken = useCase.execute()
                            .compactMap { $0 as? APIToken }
                            .asObservable()
                    }

                    it("emits nil value") {
                        let savedToken = try self.awaitPublisher(executingGetToken)
                        expect(savedToken) == nil
                    }
                }
            }
        }
    }
}
