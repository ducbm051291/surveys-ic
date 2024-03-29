//
//  Navigator+Screen.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

extension Navigator {

    enum Screen {

        case forgotPassword(_ viewModel: ForgotPasswordViewModel)
        case home
        case login
        case splash
        case survey(_ viewModel: SurveyViewModel)
    }
}
