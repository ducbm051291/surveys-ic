//
//  View+Banner.swift
//  Surveys
//
//  Created by David Bui on 02/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func banner(data: Binding<BannerData>, isVisible: Binding<Bool>) -> some View {
        modifier(BannerModifier(data: data, isVisible: isVisible))
    }
}
