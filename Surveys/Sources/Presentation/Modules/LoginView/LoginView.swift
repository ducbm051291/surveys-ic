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

    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black.opacity(0.2), location: 0.0),
            .init(color: .black, location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        setUpView()
    }

    init() {}

    private func setUpView() -> some View {
        GeometryReader { geometry in
            ZStack {
                setupBackground()
                VStack(spacing: 0.0) {
                    setUpLogo()
                        .frame(height: geometry.size.height * (1.0 / 3.0))
                        .offset(y: 20.0)
                    setupComponents()
                        .frame(height: geometry.size.height * (1.0 / 3.0))
                    Spacer()
                        .frame(height: geometry.size.height * (1.0 / 3.0))
                }
            }
        }
    }

    private func setupBackground() -> some View {
        Asset.splashScreenBackgroundImage.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ZStack(alignment: .bottom) {
                    Asset.splashScreenBackgroundImage.image
                        .resizable()
                        .blur(radius: 15.0, opaque: true)
                        .clipped()
                    gradient
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

    private func setupComponents() -> some View {
        return VStack(alignment: .leading, spacing: 20.0) {
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
        }
    }

    private func setUpPassword() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            SecureField(String.empty, text: $email)
                .modifier(PlaceholderModifier(
                    isVisible: true,
                    text: Localize.loginPasswordTextFieldPlaceholder()
                ))
        }
    }
}

struct LoginViewPreView: PreviewProvider {

    static var previews: some View {
        LoginView()
    }
}
