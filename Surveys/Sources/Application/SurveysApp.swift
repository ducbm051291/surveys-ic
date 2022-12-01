//
//  SurveysApp.swift
//  Surveys
//
//  Created by David Bui on 04/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Firebase
import SwiftUI

@main
struct SurveysApp: App {

    @StateObject var appRouter = AppRouter()

    init() {
        FirebaseApp.configure()
    }
}

extension SurveysApp {

    @ViewBuilder var rootView: some View {
        switch appRouter.state {
        case .splash: SplashView()
        case .login: LoginView()
        case .home: HomeView()
        case .forgotPassword: ForgotPasswordView()
        }
    }

    var body: some Scene {
        WindowGroup {
            rootView.environmentObject(appRouter)
        }
    }
}
