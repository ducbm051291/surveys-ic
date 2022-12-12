//
//  ForgotPasswordParameter.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct ForgotPasswordParameter: Parameterable, Codable, Equatable {

    let user: UserParameter
    let clientId: String
    let clientSecret: String
}
