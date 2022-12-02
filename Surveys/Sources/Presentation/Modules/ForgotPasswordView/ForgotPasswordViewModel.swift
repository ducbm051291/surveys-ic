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

    @Published var state: State = .idle
    @Published var email: String = ""
    @Published var isEmailValid = true
    @Published var isResetEnabled = false
}

extension ForgotPasswordViewModel {

    enum State: Equatable {

        case idle, loading
        case didReset
        case error(String)
    }
}

