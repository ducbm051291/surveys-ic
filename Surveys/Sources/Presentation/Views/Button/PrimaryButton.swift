//
//  PrimaryButton.swift
//  Surveys
//
//  Created by David Bui on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PrimaryButton: View {

    @Binding var isEnabled: Bool

    let titleColor: Color = .white
    let backgroundColor: Color = .black
    let isLoading: Bool

    var action: () -> Void
    var title: String
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .frame(maxHeight: .infinity, alignment: .center)
            } else {
                Text(title)
                    .font(.bold())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 56.0)
        .background(isEnabled ? .white : Colors.stoneGray.color)
        .foregroundColor(isEnabled ? Colors.smokeGray.color : .white)
        .disabled(isLoading || !isEnabled)
        .cornerRadius(10.0)
    }
}
