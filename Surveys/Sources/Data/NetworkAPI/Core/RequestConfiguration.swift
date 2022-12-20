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
    case surveyList(Int, Int)
}

extension RequestConfiguration: TargetType {

    var baseURL: URL { Constants.API.baseURL.toURL() }

    var path: String {
        switch self {
        case .login: return "/oauth/token"
        case .forgotPassword: return "/passwords"
        case .surveyList: return "/surveys"
        }
    }

    var method: Moya.Method {
        switch self {
        case .surveyList:
            return .get
        default:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case let .login(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case let .forgotPassword(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case let .surveyList(pageNumber, pageSize):
            return .requestParameters(
                parameters: [
                    "page[number]": pageNumber,
                    "page[size]": pageSize
                ],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: HTTPHeaders? {
        var defaultHeaders = ["Accept": "application/json"]

        if let token: KeychainToken = try? Keychain.default.get(.userToken),
           token.accessToken.isNotEmpty {
            defaultHeaders["Authorization"] = "\(token.tokenType) \(token.accessToken)"
        }

        return defaultHeaders
    }
}
