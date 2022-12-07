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
    // TODO: Remove hard-code
    @Published var email: String = "dev@nimblehq.co"
    @Published var isEmailValid = true
    @Published var isResetEnabled = true
}

extension ForgotPasswordViewModel {

    enum State: Equatable {

        case idle, loading, didReset
        case error(String)
    }
}
