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

    @Published var state: State = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled = false
    @Published var isEmailValid = true
    @Published var isPasswordValid = true
    @Published var didTapLogInButton = false

    private var cancelBag = CancelBag()

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
    }

    func logIn() {
        state = .loading

        loginUseCase.execute(email: email, password: password)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case let .failure(error):
                    guard let error = error as? NetworkAPIError else {
                        self.state = .error(Localize.commonOkText())
                        return
                    }
                    switch error {
                    case let .responseErrors(errors):
                        self.state = .error(errors.first?.detail ?? .empty)
                    default:
                        self.state = .error(Localize.commonOkText())
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] token in
                guard let self = self else { return }
                self.state = .loggedIn(token)
            }
            .store(in: &cancelBag)
    }
}

extension LoginViewModel {

    enum State {
        case idle, loading
        case loggedIn(Token)
        case error(String)
    }
}
