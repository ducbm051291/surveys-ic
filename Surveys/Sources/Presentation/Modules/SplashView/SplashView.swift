//
//  SplashView.swift
//  Surveys
//
//  Created by David Bui on 06/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SplashView: View {

    @State private var fadeInOut = false

    var body: some View {
        ZStack {
            Asset.splashScreenBackgroundImage.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Asset.logoWhiteIcon.image
                .resizable()
                .frame(width: 200.0, height: 48.0, alignment: .center)
                .onAppear(perform: {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        fadeInOut.toggle()
                    }
                })
                .opacity(fadeInOut ? 1.0 : 0.0)
        }
    }
}

struct SplashViewPreviews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
