//
//  Publisher+Driver.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

extension Publisher {

    func just(_ output: Output) -> Driver<Output> {
        Just(output).eraseToAnyPublisher()
    }

    func empty() -> Driver<Output> {
        Empty().eraseToAnyPublisher()
    }

    func asDriver() -> Driver<Output> {
        self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
