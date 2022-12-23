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
        register(CacheRepositoryProtocol.self) { CacheRepository() }
        register(SessionRepositoryProtocol.self) { SessionRepository() }
        register(SurveyRepositoryProtocol.self) { SurveyRepository() }
    }

    private static func registerServices() {
        register(SurveyCache.self) { SurveyCache() }
        register(KeychainProtocol.self) { Keychain.default }
        register(UserDefaultsManagerProtocol.self) { UserDefaultsManager.default }
        register(NetworkAPIProtocol.self) { NetworkAPI() }
    }
}
