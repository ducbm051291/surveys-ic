//
//  StoreQuestionResponseUseCaseSpec.swift
//  SurveysTests
//
//  Created by David Bui on 02/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class StoreQuestionResponseUseCaseSpec: QuickSpec {

    @LazyInjected private var questionResponseCache: QuestionResponseCache

    override func spec() {

        var useCase: StoreQuestionResponseUseCase!

        describe("A StoreQuestionResponseUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = StoreQuestionResponseUseCase()
            }

            describe("its execute() call") {

                let questionResponseToTest = QuestionResponse.dummy

                beforeEach {
                    useCase.execute(questionResponse: questionResponseToTest)
                }

                it("question response was stored in cache") {
                    let cacheQuestion = self.questionResponseCache.get(id: questionResponseToTest.id)
                    expect(cacheQuestion?.id) == questionResponseToTest.id
                }
            }
        }
    }
}
