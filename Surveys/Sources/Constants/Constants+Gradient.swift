//  swiftlint:disable:this file_name
//  Constants+Gradient.swift
//  Surveys
//
//  Created by David Bui on 21/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension Constants.Gradient {

    static let background = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black.opacity(0.2), location: 0.0),
            .init(color: .black, location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    static let surveyBackground = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .white, location: 0.0),
            .init(color: .black, location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}
