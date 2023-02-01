//
//  Resolver+Data.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
import Resolver

extension Resolver {

    static func registerDataServices() {
        registerServices()
        registerRepositories()
    }

    private static func registerRepositories() {
        register(AuthenticationRepositoryProtocol.self) { AuthenticationRepository() }
        register(SessionRepositoryProtocol.self) { SessionRepository() }
        register(SurveyRepositoryProtocol.self) { SurveyRepository() }
        register(SurveyResponseRepositoryProtocol.self) { SurveyResponseRepository() }
    }

    private static func registerServices() {
        register(SurveyCache.self) { SurveyCache() }
        register(QuestionResponseCache.self) { QuestionResponseCache() }
        register(KeychainProtocol.self) { Keychain.default }
        register(NotificationCenter.self) { NotificationCenter.default }
        register(UserDefaultsManagerProtocol.self) { UserDefaultsManager.default }
        register(NetworkAPIProtocol.self, name: .jsonNetworkAPI) { NetworkAPI.jsonDecoder }
        register(NetworkAPIProtocol.self, name: .jsonAPINetworkAPI) { NetworkAPI.jsonAPIDecoder }
    }
}

extension Resolver.Name {

    static let jsonNetworkAPI = Resolver.Name("jsonNetworkAPI")
    static let jsonAPINetworkAPI = Resolver.Name("jsonAPINetworkAPI")
}
