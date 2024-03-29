//
//  AppNavigator.swift
//  Surveys
//
//  Created by David Bui on 10/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import FlowStacks
import SwiftUI

struct AppNavigator: View {

    @StateObject var navigator = Navigator()

    var body: some View {
        Router($navigator.routes) { screen, _ in
            switch screen {
            case let .forgotPassword(viewModel): ForgotPasswordView(viewModel: viewModel)
            case .login: LoginView()
            case .home: HomeView()
            case .splash: SplashView()
            case let .survey(viewModel): SurveyView(viewModel: viewModel)
            }
        }
        .environmentObject(navigator)
    }
}
