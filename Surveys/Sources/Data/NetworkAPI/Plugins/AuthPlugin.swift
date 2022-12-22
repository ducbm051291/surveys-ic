//
//  AuthPlugin.swift
//  Surveys
//
//  Created by David Bui on 21/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Moya
import Resolver

struct AuthPlugin: PluginType {

    @Injected private var keychain: KeychainProtocol

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let token: KeychainToken = try? keychain.get(.userToken),
           token.accessToken.isNotEmpty {
            request.addValue("\(token.tokenType) \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
