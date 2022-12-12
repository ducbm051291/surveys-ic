//
//  SurveysApp.swift
//  Surveys
//
//  Created by David Bui on 04/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Firebase
import IQKeyboardManagerSwift
import SwiftUI

@main
struct SurveysApp: App {

    init() {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
    }
}

extension SurveysApp {

    var body: some Scene {
        WindowGroup {
            AppNavigator()
        }
    }
}
