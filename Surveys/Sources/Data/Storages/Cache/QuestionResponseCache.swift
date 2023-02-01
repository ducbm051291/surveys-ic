//
//  QuestionResponseCache.swift
//  Surveys
//
//  Created by David Bui on 01/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Cache

protocol QuestionResponseCacheProtocol: AnyObject {

    func get(id: String) -> APIQuestionResponse?
    func set(_ value: APIQuestionResponse)
    func remove(id: String)
}

final class QuestionResponseCache: QuestionResponseCacheProtocol {

    private let diskConfig = DiskConfig(name: Bundle.main.bundleIdentifier ?? .empty)
    private let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
    private let storage: Storage<String, APIQuestionResponse>?

    init() {
        storage = try? Storage<String, APIQuestionResponse>(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: APIQuestionResponse.self)
        )
    }

    func get(id: String) -> APIQuestionResponse? {
        try? storage?.object(forKey: id)
    }

    func set(_ value: APIQuestionResponse) {
        try? storage?.setObject(value, forKey: value.id)
    }

    func remove(id: String) {
        try? storage?.removeObject(forKey: id)
    }
}
