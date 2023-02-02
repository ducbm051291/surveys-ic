//
//  ClearQuestionResponseUseCaseSpec.swift
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

final class ClearQuestionResponseUseCaseSpec: QuickSpec {

    @LazyInjected private var questionResponseCache: QuestionResponseCache

    override func spec() {

        var useCase: ClearQuestionResponseUseCase!

        describe("A ClearQuestionResponseUseCase") {

            beforeEach {
                Resolver.registerAllMockServices()
                useCase = ClearQuestionResponseUseCase()
            }

            describe("its execute() call") {

                let questionResponseToTest = APIQuestionResponse.dummy

                beforeEach {
                    self.questionResponseCache.set(questionResponseToTest)
                    useCase.execute(id: questionResponseToTest.id)
                }

                it("return correct question response in cache") {
                    expect(self.questionResponseCache.get(id: questionResponseToTest.id)) == nil
                }
            }
        }
    }
}
