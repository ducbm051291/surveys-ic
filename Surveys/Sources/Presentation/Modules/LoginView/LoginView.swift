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

    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0.0),
            .init(color: .black.opacity(0.2), location: 1.0)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )

    var body: some View {
        GeometryReader { geo in
            ZStack {
                setupBackground()
                VStack(spacing: 0.0) {
                    setUpLogo()
                        .frame(height: geo.size.height * (1.0 / 3.0))
                        .offset(y: 20.0)
                }
            }
        }
    }

    init() {}

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
                .frame(width: 167.84, height: 40.0)
        }
    }
}

struct LoginViewPreView: PreviewProvider {

    static var previews: some View {
        LoginView()
    }
}
