//
//  ShimmerViewStyle+Application.swift
//  Surveys
//
//  Created by David Bui on 14/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import ShimmerView

extension ShimmerViewStyle {

    static let common = ShimmerViewStyle(
        baseColor: .white.withAlphaComponent(0.12),
        highlightColor: .white.withAlphaComponent(0.49),
        duration: 1.5,
        interval: 0.3,
        effectSpan: .ratio(1.0),
        effectAngle: 0.0 * CGFloat.pi
    )
}
