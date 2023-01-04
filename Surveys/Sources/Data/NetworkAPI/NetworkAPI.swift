//
//  NetworkAPI.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import JSONAPIMapper
import Moya
import Resolver

final class NetworkAPI: NetworkAPIProtocol {

    @Injected private var keychain: KeychainProtocol
    @LazyInjected private var notificationCenter: NotificationCenter

    private let provider = MoyaProvider<RequestConfiguration>(plugins: [AuthPlugin()])
    private let decoder: JSONAPIDecoder

    init(decoder: JSONAPIDecoder = JSONAPIDecoder.default) {
        self.decoder = decoder
    }

    func performRequest<T>(
        _ configuration: RequestConfiguration,
        for type: T.Type
    ) -> Observable<T> where T: Decodable {
        provider.requestPublisher(configuration)
            .map { self.checkExpiredToken($0, configuration) }
            .asObservable()
            .switchToLatest()
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> Error in
                guard let errors = error as? [JSONAPIError] else { return NetworkAPIError.generic }
                return NetworkAPIError.responseErrors(errors: errors)
            }
            .asObservable()
    }

    private func checkExpiredToken(
        _ response: Response,
        _ configuration: RequestConfiguration
    ) -> Observable<Response> {
        if response.statusCode == 401 {
            guard let token: KeychainToken = try? keychain.get(.userToken),
                  token.refreshToken.isNotEmpty else {
                self.removeExpiredToken()
                self.notifyExpiredToken()
                return Just(response).asObservable()
            }
            return refreshToken(token.refreshToken)
                .flatMap { token in
                    try? self.keychain.set(KeychainToken(token), for: .userToken)
                    // Re-call failed API
                    return self.provider.requestPublisher(configuration).asObservable()
                }
                .asObservable()
        } else {
            return Just(response).asObservable()
        }
    }

    private func removeExpiredToken() {
        try? keychain.remove(.userToken)
    }

    private func notifyExpiredToken() {
        notificationCenter.post(.unauthenticated)
    }

    private func refreshToken(_ token: String) -> Observable<Token> {
        let refreshTokenParameter = RefreshTokenParameter(
            grantType: Constants.GrantType.refreshToken.rawValue,
            refreshToken: token,
            clientId: Constants.API.clientId,
            clientSecret: Constants.API.clientSecret
        )
        let refreshTokenConfiguration = RequestConfiguration.refreshToken(refreshTokenParameter)
        return provider.requestPublisher(refreshTokenConfiguration)
            .map { $0.data }
            .decode(type: APIToken.self, decoder: decoder)
            .mapError { _ -> Error in
                self.removeExpiredToken()
                self.notifyExpiredToken()
                return NetworkAPIError.unauthenticated
            }
            .compactMap { $0 as? Token }
            .asObservable()
    }
}
