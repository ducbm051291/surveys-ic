//
//  RoundCloseButtonModifier.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct RoundCloseButtonModifier: ViewModifier {

    var action: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            Button {
                action()
            } label: {
                Assets.roundCloseIcon.image
                    .frame(
                        width: 28.0,
                        height: 28.0
                    )
                    .clipShape(Circle())
            }
        }
    }
}
