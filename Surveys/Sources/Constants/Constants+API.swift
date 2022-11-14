//  swiftlint:disable:this file_name
//
//  Constants+API.swift
//

import Keys

extension Constants.API {

    static let baseURL: String = "https://\((try? Environment.value(for: .apiBaseURL)) ?? "")/"
    static let clientId: String = SurveysKeys().clientId
    static let clientSecret: String = SurveysKeys().clientSecret
}
