//
//  SessionRepositoryProtocol.swift
//  Surveys
//
//  Created by David Bui on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

final class SessionRepository: SessionRepositoryProtocol {

    @Injected private var keychain: KeychainProtocol

    func hasToken() -> Observable<Bool> {
        getToken().map { $0.hasValue }.asObservable()
    }

    func getToken() -> Observable<Token?> {
        guard let token: KeychainToken = try? keychain.get(.userToken),
              token.accessToken.isNotEmpty
        else { return Just(nil).asObservable() }
        return Just(token).asObservable()
    }

    func removeToken() -> Observable<Bool> {
        do {
            try keychain.remove(.userToken)
            return Just(true).asObservable()
        } catch {
            return Just(false).asObservable()
        }
    }

    func saveToken(_ token: Token) -> Observable<Bool> {
        do {
            try keychain.set(KeychainToken(token), for: .userToken)
            return Just(true).asObservable()
        } catch {
            return Just(false).asObservable()
        }
    }
}
