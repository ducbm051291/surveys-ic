//
//  APIToken+Dummy.swift
//  SurveysTests
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Surveys

extension APIToken {

    static let dummy = APIToken(
        accessToken: "4vMH6ElDSmgYyjFP921dVj0iqPk4IrVq8QspjloYWNc",
        tokenType: "Bearer",
        expiresIn: 720,
        refreshToken: "ZwFDi9G364xc3r7C977xyLdvECiJ-yCpLbv7xim7894",
        createdAt: 1_668_667_070
    )
}
