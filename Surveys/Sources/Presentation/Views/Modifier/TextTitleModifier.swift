//
//  TextTitleModifier.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TextTitleModifier: ViewModifier {

    var titleSize: Font.Size = .large

    func body(content: Content) -> some View {
        content
            .font(.bold(ofSize: titleSize))
            .foregroundColor(.white)
    }
}
