//
//  Cache.swift
//  Surveys
//
//  Created by David Bui on 22/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Cache

protocol CacheProtocol: AnyObject {

    associatedtype Value: Codable

    func get() throws -> Value?
    func set(_ value: Value) throws
    func remove() throws
}
