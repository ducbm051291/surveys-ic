//
//  SplashView.swift
//  Surveys
//
//  Created by David Bui on 06/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SplashView: View {

    @EnvironmentObject private var appRouter: AppRouter
    @State private var fadeInOut = false

    // TODO: Remove timer after finishing login flow
    private let timer = Timer.publish(every: 2.0, on: .main, in: .default).autoconnect()

    var body: some View {
        ZStack {
            Asset.splashScreenBackgroundImage.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Asset.logoWhiteIcon.image
                .resizable()
                .frame(width: 200.0, height: 48.0, alignment: .center)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        fadeInOut.toggle()
                    }
                }
                .opacity(fadeInOut ? 1.0 : 0.0)
        }
        .onReceive(timer) { _ in
            appRouter.state = .login
            timer.upstream.connect().cancel()
        }
    }
}

struct SplashViewPreviews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
