//
//  View+Hidden.swift
//  Surveys
//
//  Created by David Bui on 29/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func hidden(_ shouldHide: Bool) -> some View {
        return opacity(shouldHide ? 0.0 : 1.0)
    }
}
