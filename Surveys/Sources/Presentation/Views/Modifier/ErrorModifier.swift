//
//  ErrorModifier.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct ErrorModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.regular(ofSize: .xxSmall))
                .foregroundColor(.red)
                .padding()
                .frame(height: 12.0, alignment: .leading)
        }
    }
}
