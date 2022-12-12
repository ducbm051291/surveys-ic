//
//  Combine+Collect.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

// Original from https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/

extension Published.Publisher {

    func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        dropFirst()
            .collect(count)
            .first()
            .eraseToAnyPublisher()
    }
}
