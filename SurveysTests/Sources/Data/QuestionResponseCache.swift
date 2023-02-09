//
//  QuestionResponseCache.swift
//  SurveysTests
//
//  Created by David Bui on 03/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Cache
import Combine
import Nimble
import Quick
import Resolver

@testable import Surveys

final class QuestionResponseCacheSpec: QuickSpec {

    override func spec() {

        describe("A QuestionResponseCache") {
            var cache: QuestionResponseCache!
            let questionResponseToTest = QuestionResponse.dummy

            beforeEach {
                let storage = try? Storage<String, QuestionResponse>(
                    diskConfig: Constants.Cache.diskConfig,
                    memoryConfig: Constants.Cache.memoryConfig,
                    transformer: TransformerFactory.forCodable(ofType: QuestionResponse.self)
                )
                cache = QuestionResponseCache(storage: storage)
            }

            afterEach {
                cache.remove(id: questionResponseToTest.id)
            }

            it("sets and retrieves a question response") {
                cache.set(questionResponseToTest)
                expect(cache.get(id: questionResponseToTest.id)?.id).to(equal(questionResponseToTest.id))
            }

            it("removes a question response") {
                cache.set(questionResponseToTest)
                cache.remove(id: questionResponseToTest.id)
                expect(cache.get(id: questionResponseToTest.id)).to(beNil())
            }
        }
    }
}
