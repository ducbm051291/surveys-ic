//
//  Resolver+ResolverRegistering.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerDataServices()
        registerDomainServices()
    }
}
