//
//  LoginViewModel.swift
//  Surveys
//
//  Created by David Bui on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class LoginViewModel: ObservableObject {

    @Injected private var loginUseCase: LoginUseCaseProtocol
    @Injected private var storeTokenUseCase: StoreTokenUseCaseProtocol

    @Published var state: State = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled = false
    @Published var isEmailValid = true
    @Published var isPasswordValid = true

    private var cancelBag = CancelBag()
    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init() {
        let emailValidation = $email
            .map { $0.validate(.email) && $0.isNotEmpty }
            .dropFirst()

        emailValidation
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancelBag)

        let passwordValidation = $password
            .map { $0.validate(.password) && $0.isNotEmpty }
            .dropFirst()

        passwordValidation
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancelBag)

        Publishers.CombineLatest(emailValidation, passwordValidation)
            .map { $0.0 && $0.1 }
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &cancelBag)

        let errorState = errorTracker
            .catchError()
            .map { State.error($0) }

        let loadingState = activityTracker
            .receive(on: DispatchQueue.main)
            .filter { $0 }
            .map { _ in State.loading }

        Publishers.Merge(errorState, loadingState)
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)
    }

    func logIn() {
        guard isLoginEnabled else { return }
        loginUseCase.execute(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .flatMap { token in
                self.storeTokenUseCase.execute(token: token)
            }
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .asDriver()
            .map { _ in State.loggedIn }
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)
    }
}

extension LoginViewModel {

    enum State: Equatable {

        case idle, loading, loggedIn
        case error(String)
    }
}
