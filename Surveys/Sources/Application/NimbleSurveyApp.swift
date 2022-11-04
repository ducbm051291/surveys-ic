//
//  NimbleSurveyApp.swift
//  Surveys
//
//  Created by David Bui on 04/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Firebase
import SwiftUI

@main
struct NimbleSurveyApp: App {

    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }

    init() {
        FirebaseApp.configure()
    }
}
