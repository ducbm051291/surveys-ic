//
//  SplashViewModel.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SplashViewModel: ObservableObject {

    @Injected private var getTokenUseCase: GetTokenUseCaseProtocol

    @Published var state: State = .idle

    init() {
        getTokenUseCase.execute()
            .map { $0 == nil ? .unauthenticated : .authenticated }
            .asDriver()
            .assign(to: &$state)
    }
}

extension SplashViewModel {

    enum State: Equatable {

        case idle, unauthenticated, authenticated
    }
}
