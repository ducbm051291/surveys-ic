//
//  NavigationBackButtonModifier.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct NavigationBackButtonModifier: ViewModifier {

    var action: () -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: action) {
                Assets.arrowLeftWhiteIcon.image
            })
    }
}
