//
//  APIEmpty.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Surveys

extension APIEmpty {

    static let dummy = APIEmpty(
        meta: MessageMeta(
            message: "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes."
        )
    )
}
