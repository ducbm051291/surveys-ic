//
//  KeychainToken.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct KeychainToken: Token, Codable {

    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createAt: Int

    init(_ token: Token) {
        accessToken = token.accessToken
        tokenType = token.tokenType
        expiresIn = token.expiresIn
        refreshToken = token.refreshToken
        createAt = token.createAt
    }
}
