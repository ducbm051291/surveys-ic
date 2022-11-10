//
//  AppRouter.swift
//  Surveys
//
//  Created by David Bui on 10/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

enum Route: Hashable {

    case splash
}

final class AppRouter: ObservableObject {

    @Published var state: Route = .splash
}
