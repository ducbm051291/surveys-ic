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

    // TODO: Replace state variables
    @State var email = ""
    @State var password = ""
    @State var isLoginEnabled = true

    var body: some View {
        ZStack {
            setUpBackground()
            VStack(spacing: 0.0) {
                setUpLogo()
                    .frame(maxHeight: .infinity)
                setUpComponents()
                    .frame(maxHeight: .infinity)
                Spacer()
                    .frame(maxHeight: .infinity)
            }
        }
    }

    private func setUpBackground() -> some View {
        Asset.splashScreenBackgroundImage.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ZStack {
                    Asset.splashScreenBackgroundImage.image
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
            Asset.logoWhiteIcon.image
                .resizable()
                .frame(width: 168.0, height: 40.0)
        }
    }

    private func setUpComponents() -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            setUpEmail()
            setUpPassword()
            PrimaryButton(
                isEnabled: $isLoginEnabled,
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
