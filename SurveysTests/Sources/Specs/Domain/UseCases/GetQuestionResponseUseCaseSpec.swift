//  swiftlint:disable:redundantNilInit
//  GetQuestionResponseUseCaseSpec.swift
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

final class GetQuestionResponseUseCaseSpec: QuickSpec {

    @LazyInjected private var questionResponseCache: QuestionResponseCache

    override func spec() {

        var useCase: GetQuestionResponseUseCase!

        describe("A GetQuestionResponseUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = GetQuestionResponseUseCase()
            }

            describe("its execute() call") {

                let questionResponseToTest = QuestionResponse.dummy
                var questionResponseInCache: QuestionResponse?

                beforeEach {
                    self.questionResponseCache.set(questionResponseToTest)
                    questionResponseInCache = useCase.execute(id: questionResponseToTest.id)
                }

                it("return correct question response in cache") {
                    expect(questionResponseInCache?.id) == questionResponseToTest.id
                }
            }
        }
    }
}
