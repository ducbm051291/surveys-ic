//
//  LoginParameter.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct LoginParameter: Parameterable, Codable, Equatable {

    let grantType: String
    let email: String
    let password: String
    let clientId: String
    let clientSecret: String
}
