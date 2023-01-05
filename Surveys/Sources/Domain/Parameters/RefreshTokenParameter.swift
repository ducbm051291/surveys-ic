//
//  RefreshTokenParameter.swift
//  Surveys
//
//  Created by David Bui on 29/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct RefreshTokenParameter: Parameterable, Codable, Equatable {

    let grantType: String
    let refreshToken: String
    let clientId: String
    let clientSecret: String
}
