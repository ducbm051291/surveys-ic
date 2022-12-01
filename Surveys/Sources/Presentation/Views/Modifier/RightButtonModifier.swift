//
//  RightButtonModifier.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct RightButtonModifier: ViewModifier {

    var action: () -> Void
    var title: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            Button(action: action) {
                Text(title)
                    .font(.regular(ofSize: .small))
            }
            .frame(maxWidth: 60.0, maxHeight: 20.0)
            .background(Color.clear)
            .foregroundColor(.white.opacity(0.5))
            .padding(.trailing, 12.0)
        }
    }
}
