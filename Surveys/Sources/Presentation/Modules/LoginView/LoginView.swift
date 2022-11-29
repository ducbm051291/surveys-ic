//
//  LoginView.swift
//  Surveys
//
//  Created by David Bui on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct LoginView: View {

    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = LoginViewModel()

    // TODO: Replace state variables
    @State var email = ""
    @State var password = ""
    @State var isLoginEnabled = true

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
        case .loading:
            setUpView(isLoading: true)
        case .loggedIn:
            setUpView()
                .onAppear {
                    // Navigate to home
                }
        case let .error(message):
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text(Localize.commonApplicationNameText()),
                        message: Text(message),
                        dismissButton: Alert.Button.default(Text(Localize.commonOkText()))
                    )
                }
        }
    }

    private func setUpView(isLoading: Bool = false) -> some View {
        ZStack {
            setUpBackground()
            VStack(spacing: 0.0) {
                setUpLogo()
                    .frame(maxHeight: .infinity)
                setUpComponents(isLoading: isLoading)
                    .frame(maxHeight: .infinity)
                Spacer()
                    .frame(maxHeight: .infinity)
            }
        }
    }

    private func setUpBackground() -> some View {
        Assets.backgroundImage.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ZStack {
                    Assets.backgroundImage.image
                        .resizable()
                        .blur(radius: 15.0, opaque: true)
                        .clipped()
                    Constants.Gradient.background
                }
            )
            .edgesIgnoringSafeArea(.all)
    }

    private func setUpLogo() -> some View {
        VStack {
            Assets.logoWhiteIcon.image
                .resizable()
                .frame(width: 168.0, height: 40.0)
        }
    }

    private func setUpComponents(isLoading: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            setUpEmail()
            setUpPassword()
            PrimaryButton(
                isEnabled: $isLoginEnabled,
                isLoading: isLoading,
                action: {},
                title: Localize.loginLoginButtonTitle()
            )
        }
        .padding([.leading, .trailing], 24.0)
    }

    private func setUpEmail() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            TextField(String.empty, text: $email)
                .modifier(PlaceholderModifier(
                    isVisible: true,
                    text: Localize.loginEmailTextFieldPlaceholder()
                ))
            Text(Localize.loginInvalidEmailText())
                .modifier(ErrorModifier())
                .padding(.top, 4.0)
        }
    }

    private func setUpPassword() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            SecureField(String.empty, text: $email)
                .modifier(PlaceholderModifier(
                    isVisible: true,
                    text: Localize.loginPasswordTextFieldPlaceholder()
                ))
            Text(Localize.loginInvalidPasswordText())
                .modifier(ErrorModifier())
                .padding(.top, 4.0)
        }
    }
}

struct LoginViewPreView: PreviewProvider {

    static var previews: some View {
        LoginView()
    }
}
