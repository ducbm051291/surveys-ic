//
//  APIRequest.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Moya

enum APIRequest {

    case login(LoginParameter)
}

extension APIRequest: TargetType {

    var baseURL: URL { URL(string: Constants.API.baseURL)! }

    var path: String {
        switch self {
        case .login: return "/oauth/token"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login: return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case let .login(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? { nil }
}