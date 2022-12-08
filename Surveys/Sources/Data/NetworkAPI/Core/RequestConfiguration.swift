//
//  APIRequest.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Moya

enum RequestConfiguration: Equatable {

    case login(LoginParameter)
    case forgotPassword(ForgotPasswordParameter)
}

extension RequestConfiguration: TargetType {

    var baseURL: URL { Constants.API.baseURL.toURL() }

    var path: String {
        switch self {
        case .login: return "/oauth/token"
        case .forgotPassword: return "/passwords"
        }
    }

    var method: Moya.Method {
        .post
    }

    var task: Moya.Task {
        switch self {
        case let .login(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case let .forgotPassword(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        }
    }

    var headers: HTTPHeaders? {
        ["Accept": "application/json"]
    }
}
