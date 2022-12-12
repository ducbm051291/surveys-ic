//
//  PlaceholderModifier.swift
//  Surveys
//
//  Created by David Bui on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PlaceholderModifier: ViewModifier {

    var isVisible: Bool
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if isVisible {
                Text(text)
                    .font(.regular())
                    .padding(.horizontal, 18.0)
                    .foregroundColor(.white)
                    .opacity(0.3)
            }
            content
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.regular())
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: Constants.View.defaultHeight)
                .background(
                    RoundedRectangle(
                        cornerRadius: 12.0,
                        style: .continuous
                    )
                    .fill(.white.opacity(0.18))
                )
        }
    }
}
