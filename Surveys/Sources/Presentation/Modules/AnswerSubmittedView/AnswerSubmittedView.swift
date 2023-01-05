//
//  AnswerSubmittedView.swift
//  Surveys
//
//  Created by David Bui on 03/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct AnswerSubmittedView: View {

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        setUpView()
    }

    private func setUpView(isLoading: Bool = false) -> some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .center) {
                    LottieView(lottieFile: "successful")
                        .frame(
                            width: 200.0,
                            height: 200.0
                        )
                    Text(Localize.aswerSubmittedViewThanksText())
                        .modifier(TextTitleModifier(titleSize: .xLarge))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AnswerSubmittedViewPreview: PreviewProvider {

    static var previews: some View {
        AnswerSubmittedView()
    }
}
