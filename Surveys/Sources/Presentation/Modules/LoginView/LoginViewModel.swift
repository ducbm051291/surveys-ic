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

        errorTracker
            .receive(on: RunLoop.main)
            .map { error -> LoginViewModel.State in
                guard let error = error as? NetworkAPIError else {
                    return .error(Localize.commonErrorText())
                }
                switch error {
                case let .responseErrors(errors):
                    return .error(errors.first?.detail ?? .empty)
                default:
                    return .error(Localize.commonErrorText())
                }
            }
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)

        activityTracker
            .receive(on: RunLoop.main)
            .filter { $0 }
            .map { _ in .loading }
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)
    }

    func logIn() {
        loginUseCase.execute(email: email, password: password)
            .receive(on: RunLoop.main)
            .flatMap { token in
                self.storeTokenUseCase.execute(token: token)
            }
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .asDriver()
            .map { _ in .loggedIn }
            .assign(to: \.state, on: self)
            .store(in: &cancelBag)
    }
}

extension LoginViewModel {

    enum State {
        case idle, loading
        case loggedIn
        case error(String)
    }
}
