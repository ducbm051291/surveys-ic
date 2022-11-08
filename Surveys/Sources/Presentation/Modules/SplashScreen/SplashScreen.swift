//
//  SplashScreen.swift
//  NimbleSurvey
//
//  Created by David Bui on 06/05/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SplashScreen: View {

    var body: some View {
        Text("Hello Nimble")
    }
}

#if DEBUG
    struct SplashScreen_Previews: PreviewProvider {

        static var previews: some View {
            SplashScreen()
        }
    }
#endif
