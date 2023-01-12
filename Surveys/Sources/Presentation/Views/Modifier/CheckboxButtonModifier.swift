//
//  CheckboxButtonModifier.swift
//  Surveys
//
//  Created by David Bui on 09/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import SwiftUI

struct CheckboxButtonModifier: ViewModifier {

    @Binding var isChecked: Bool
    var action: () -> Void
    private var image: Image {
        isChecked ? Assets.whiteCheckedCircleIcon.image : Assets.whiteUncheckCircleIcon.image
    }

    func body(content: Content) -> some View {
        ZStack {
            Button {
                isChecked.toggle()
                action()
            } label: {
                image
                    .frame(
                        width: 24.0,
                        height: 24.0
                    )
                    .background(.clear)
                    .clipShape(Circle())
            }
        }
    }
}
