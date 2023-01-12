//
//  TextFieldFormModifier.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct TextFieldFormModifier: ViewModifier {

    var isPlaceholderVisible: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if isPlaceholderVisible {
                setUpPlaceholder()
            }
            content
                .textFieldStyle(.plain)
                .font(.regular())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10.0,
                        style: .continuous
                    )
                    .fill(.white)
                    .opacity(isPlaceholderVisible ? 0.2 : 0.3)
                )
                .frame(height: 56.0)
        }
    }

    private func setUpPlaceholder() -> some View {
        Text(placeholder)
            .font(.regular())
            .foregroundColor(.white.opacity(0.3))
            .padding(.horizontal, 16.0)
    }
}
