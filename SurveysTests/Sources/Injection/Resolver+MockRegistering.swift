//
//  Resolver+MockRegistering.swift
//  SurveysTests
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Resolver

@testable import Surveys

extension Resolver {

    // MARK: - Mock Container

    static var mock = Resolver(child: main)

    // MARK: - Register All Mock Services

    public static func registerAllMockServices() {
        root = mock
        defaultScope = .application
        registerDataServices()
        registerDomainServices()
    }
}
