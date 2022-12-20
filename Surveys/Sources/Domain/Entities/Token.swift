//
//  Token.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Token {

    var accessToken: String { get }
    var tokenType: String { get }
    var expiresIn: Int { get }
    var refreshToken: String { get }
    var createdAt: Int { get }
}
