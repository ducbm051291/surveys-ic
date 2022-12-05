//
//  AuthenticationRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

// sourcery: AutoMockable
protocol AuthenticationRepositoryProtocol: AnyObject {

    func forgotPassword(email: String) -> Observable<APIEmpty>
    func login(email: String, password: String) -> Observable<Token>
}
