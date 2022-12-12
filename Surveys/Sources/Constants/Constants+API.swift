//  swiftlint:disable:this file_name
//
//  Constants+API.swift
//

import SurveysKeys

extension Constants.API {

    static let baseURL: String = "https://\((try? Environment.value(for: .apiBaseURL)) ?? "")/"

    #if STAGING
        static let clientId: String = SurveysKeys.Keys.Debug().clientId
        static let clientSecret: String = SurveysKeys.Keys.Debug().clientSecret
    #elseif PRODUCTION
        static let clientId: String = SurveysKeys.Keys.Release().clientId
        static let clientSecret: String = SurveysKeys.Keys.Release().clientSecret
    #endif
}
