//
//  TextDescriptionModifier.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TextDescriptionModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.regular())
            .foregroundColor(.white.opacity(0.7))
    }
}
