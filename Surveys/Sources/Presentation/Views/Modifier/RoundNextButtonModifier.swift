//
//  RoundNextButtonModifier.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct RoundNextButtonModifier: ViewModifier {

    var action: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            Button {
                action()
            } label: {
                Assets.arrowRightBlackIcon.image
                    .frame(
                        width: 56.0,
                        height: 56.0
                    )
                    .background(.white)
                    .clipShape(Circle())
            }
        }
    }
}
