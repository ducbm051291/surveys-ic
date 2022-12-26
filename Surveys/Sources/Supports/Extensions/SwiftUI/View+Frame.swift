//
//  View+Frame.swift
//  Surveys
//
//  Created by David Bui on 26/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func fullScreenFrame() -> some View {
        return frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}
