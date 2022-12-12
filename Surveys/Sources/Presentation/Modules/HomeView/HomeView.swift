//
//  HomeView.swift
//  Surveys
//
//  Created by David Bui on 30/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct HomeView: View {

    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        ZStack {
            TabView {}
        }
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
