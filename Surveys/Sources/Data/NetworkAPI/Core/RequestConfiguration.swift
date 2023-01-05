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
    case refreshToken(RefreshTokenParameter)
    case surveyDetail(String)
    case surveyList(Int, Int)
}

extension RequestConfiguration: TargetType, AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        switch self {
        case .login, .forgotPassword, .refreshToken: return .none
        case .surveyDetail, .surveyList: return .bearer
        }
    }

    var baseURL: URL { Constants.API.baseURL.toURL() }

    var path: String {
        switch self {
        case .login, .refreshToken: return "oauth/token"
        case .forgotPassword: return "passwords"
        case .surveyList: return "surveys"
        case let .surveyDetail(surveyId):
            return "surveys/\(surveyId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .surveyDetail, .surveyList: return .get
        case .forgotPassword, .login, .refreshToken: return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case let .forgotPassword(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case let .login(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case let .refreshToken(parameter):
            return .requestParameters(parameters: parameter.dictionary, encoding: JSONEncoding.default)
        case .surveyDetail:
            return .requestPlain
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
        ["Accept": "application/json"]
    }
}
