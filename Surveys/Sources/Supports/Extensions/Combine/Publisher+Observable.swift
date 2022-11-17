//
//  Publisher+Observable.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

extension Publisher {

    func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func empty() -> Observable<Output> {
        Empty().eraseToAnyPublisher()
    }

    func asObservable() -> Observable<Output> {
        mapError { $0 }
            .eraseToAnyPublisher()
    }
}
