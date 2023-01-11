//
//  TextEditorFormModifier.swift
//  Surveys
//
//  Created by David Bui on 10/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct TextEditorFormModifier: ViewModifier {

    var isPlaceholderVisible: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            if isPlaceholderVisible {
                setUpPlaceholder()
            }
            content
                .frame(height: 168.0)
        }
    }

    private func setUpPlaceholder() -> some View {
        Text(placeholder)
            .font(.regular())
            .foregroundColor(.white.opacity(0.3))
            .padding(.top, 8.0)
            .padding(.leading, 4.0)
    }
}
