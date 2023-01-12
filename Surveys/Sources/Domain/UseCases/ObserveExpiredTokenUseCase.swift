//
//  ObserveExpiredTokenUseCase.swift
//  Surveys
//
//  Created by David Bui on 30/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol ObserveExpiredTokenUseCaseProtocol {

    func execute() -> Observable<Void>
}

final class ObserveExpiredTokenUseCase: ObserveExpiredTokenUseCaseProtocol {

    @Injected private var notificationCenter: NotificationCenter

    func execute() -> Observable<Void> {
        notificationCenter.publisher(for: Notification.Name.unauthenticated)
            .map { _ in () }
            .asObservable()
    }
}
