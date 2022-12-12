//
//  Navigator+Screen.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

extension Navigator {

    enum Screen {

        case login
        case home
        case forgotPassword(_ viewModel: ForgotPasswordViewModel)
    }
}
