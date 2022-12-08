//
//  ForgotPasswordViewModel.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class ForgotPasswordViewModel: ObservableObject {

    @Injected private var forgotPasswordUseCase: ForgotPasswordUseCaseProtocol

    @Published var state: State = .idle
    @Published var email: String = .empty
    @Published var isResetEnabled = false

    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init(email: String) {
        self.email = email

        $email.map { $0.isNotEmpty }
            .assign(to: &$isResetEnabled)

        let errorState = errorTracker
            .catchError()
            .map { State.error($0) }

        let loadingState = activityTracker
            .filter { $0 }
            .map { _ in State.loading }

        Publishers.Merge(errorState, loadingState)
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }

    func resetPassword() {
        guard isResetEnabled else { return }
        forgotPasswordUseCase.execute(email: email)
            .receive(on: DispatchQueue.main)
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .asDriver()
            .map { .didReset($0.message) }
            .assign(to: &$state)
    }
}

extension ForgotPasswordViewModel {

    enum State: Equatable {

        case idle, loading
        case didReset(String)
        case error(String)
    }
}
