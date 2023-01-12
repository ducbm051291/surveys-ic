//
//  SplashView.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct SplashView: View {

    @EnvironmentObject private var navigator: Navigator
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
        case .unauthenticated:
            setUpView()
                .onAppear {
                    navigator.show(
                        screen: .login,
                        by: .root,
                        embedInNavigationView: true
                    )
                }
        case .authenticated:
            setUpView()
                .onAppear {
                    navigator.show(
                        screen: .home,
                        by: .root,
                        embedInNavigationView: true
                    )
                }
        }
    }

    private func setUpView() -> some View {
        ZStack {
            setUpBackground()
            setUpLogo()
        }
    }

    private func setUpBackground() -> some View {
        Assets.backgroundImage.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }

    private func setUpLogo() -> some View {
        VStack(alignment: .center) {
            Assets.logoWhiteIcon.image
                .resizable()
                .frame(width: 200.0, height: 48.0)
        }
    }
}

struct SplashViewPreView: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
