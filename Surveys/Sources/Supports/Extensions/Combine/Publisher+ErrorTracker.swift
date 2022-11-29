//
//  Publisher+ErrorTracker.swift
//  Surveys
//
//  Created by David Bui on 29/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

public typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher where Failure == Error {

    public func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
