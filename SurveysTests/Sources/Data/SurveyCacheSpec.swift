//
//  SurveyCacheSpec.swift
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

final class SurveyCacheSpec: QuickSpec {

    override func spec() {

        describe("A SurveyCache") {
            var cache: SurveyCache!

            beforeEach {
                let storage = try? Storage<String, [APISurvey]>(
                    diskConfig: Constants.Cache.diskConfig,
                    memoryConfig: Constants.Cache.memoryConfig,
                    transformer: TransformerFactory.forCodable(ofType: [APISurvey].self)
                )
                cache = SurveyCache(storage: storage)
            }

            afterEach {
                cache.remove()
            }

            let surveysToTest = [APISurvey](repeating: APISurvey.dummy, count: 3)

            it("sets and retrieves a list of surveys") {
                cache.set(surveysToTest)
                expect(cache.get()).to(equal(surveysToTest))
            }

            it("removes the list of surveys") {
                cache.set(surveysToTest)
                cache.remove()
                expect(cache.get()).to(beNil())
            }
        }
    }
}
