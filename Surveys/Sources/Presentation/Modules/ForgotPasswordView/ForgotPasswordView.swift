//
//  ForgotPasswordView.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct ForgotPasswordView: View {

    @EnvironmentObject private var navigator: Navigator
    @StateObject private var viewModel = ForgotPasswordViewModel()

    // TODO: Remove dummy data
    @State var isBannerVisible: Bool = true
    @State var bannerData = BannerData(
        title: Localize.forgotPasswordResetBannerTitleText(),
        detail: Localize.forgotPasswordResetBannerDescriptionText()
    )

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
        case .loading:
            setUpView(isLoading: true)
        case .didReset:
            setUpView()
                .banner(data: $bannerData, isVisible: $isBannerVisible)
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
        .navigationBarBackButtonHidden(true)
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
        VStack(spacing: 32.0) {
            Assets.logoWhiteIcon.image
                .resizable()
                .frame(width: 168.0, height: 40.0)
            Text(Localize.forgotPasswordDescriptionText())
                .font(.regular())
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .frame(height: 44.0)
                .padding(.horizontal, 24.0)
        }
    }

    private func setUpComponents(isLoading: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            setUpEmail()
            PrimaryButton(
                isEnabled: $viewModel.isResetEnabled,
                isLoading: isLoading,
                action: { viewModel.state = .didReset },
                title: Localize.forgotPasswordResetButtonTitle()
            )
        }
        .padding([.leading, .trailing], 24.0)
    }

    private func setUpEmail() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            TextField(String.empty, text: $viewModel.email)
                .modifier(PlaceholderModifier(
                    isVisible: viewModel.email.isEmpty,
                    text: Localize.forgotPasswordEmailTextFieldPlaceholder()
                ))
        }
    }
}

struct ForgotPasswordViewPreView: PreviewProvider {

    static var previews: some View {
        ForgotPasswordView()
    }
}
