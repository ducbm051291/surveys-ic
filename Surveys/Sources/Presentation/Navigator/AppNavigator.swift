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
        NavigationStack {
            Router($navigator.routes) { screen, _ in
                switch screen {
                case .forgotPassword: ForgotPasswordView()
                case .login: LoginView()
                case .home: HomeView()
                case .splash: SplashView()
                }
            }
        }.environmentObject(navigator)
    }
}
