//
//  QuestionResponseCache.swift
//  Surveys
//
//  Created by David Bui on 01/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Cache

protocol QuestionResponseCacheProtocol: AnyObject {

    func get(id: String) -> QuestionResponse?
    func set(_ value: QuestionResponse)
    func remove(id: String)
}

final class QuestionResponseCache: QuestionResponseCacheProtocol {

    private let diskConfig = DiskConfig(name: Bundle.main.bundleIdentifier ?? .empty)
    private let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
    private let storage: Storage<String, QuestionResponse>?

    init() {
        storage = try? Storage<String, QuestionResponse>(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: QuestionResponse.self)
        )
    }

    func get(id: String) -> QuestionResponse? {
        try? storage?.object(forKey: id)
    }

    func set(_ value: QuestionResponse) {
        try? storage?.setObject(value, forKey: value.id)
    }

    func remove(id: String) {
        try? storage?.removeObject(forKey: id)
    }
}
