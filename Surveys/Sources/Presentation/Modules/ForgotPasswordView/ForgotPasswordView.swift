//
//  ForgotPasswordView.swift
//  Surveys
//
//  Created by David Bui on 01/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct ForgotPasswordView: View {

    @EnvironmentObject private var appRouter: AppRouter

    var body: some View {
        ZStack {}
            .navigationBarBackButtonHidden(false)
    }
}

struct ForgotPasswordViewPreView: PreviewProvider {

    static var previews: some View {
        ForgotPasswordView()
    }
}
