//  swiftlint:disable:this file_name
//
//  Constants+API.swift
//

import SurveysKeys

extension Constants.API {

    static let baseURL: String = "https://\((try? Environment.value(for: .apiBaseURL)) ?? "")/"
    static let clientId: String = SurveysKeys.Keys.Release().clientId
    static let clientSecret: String = SurveysKeys.Keys.Release().clientSecret
}
