//
//  SurveyCache.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Cache

protocol SurveyCacheProtocol: AnyObject {

    func get() -> [APISurvey]?
    func set(_ value: [APISurvey])
    func remove()
}

final class SurveyCache: SurveyCacheProtocol {

    private let diskConfig = DiskConfig(name: Bundle.main.bundleIdentifier ?? .empty)
    private let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
    private let storage: Storage<String, [APISurvey]>?

    init() {
        storage = try? Storage<String, [APISurvey]>(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [APISurvey].self)
        )
    }

    func get() -> [APISurvey]? {
        try? storage?.object(forKey: CacheKey.surveyList.rawValue)
    }

    func set(_ value: [APISurvey]) {
        try? storage?.setObject(value, forKey: CacheKey.surveyList.rawValue)
    }

    func remove() {
        try? storage?.removeObject(forKey: CacheKey.surveyList.rawValue)
    }
}
