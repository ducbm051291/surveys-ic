//  swiftlint:disable:this file_name
//  Constants+Cache.swift
//  Surveys
//
//  Created by David Bui on 03/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Cache
import Foundation

extension Constants.Cache {

    static let diskConfig = DiskConfig(name: Bundle.main.bundleIdentifier ?? .empty)
    static let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 10)
}
