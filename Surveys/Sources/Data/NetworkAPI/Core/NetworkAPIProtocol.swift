//
//  NetworkAPIProtocol.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import JSONAPIMapper
import Moya

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Observable<T>
}

extension NetworkAPIProtocol {

    func request<T: Decodable>(
        _ configuration: RequestConfiguration,
        provider: MoyaProvider<RequestConfiguration>,
        decoder: JSONDecoder
    ) -> Observable<T> {
        return provider.requestPublisher(configuration)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> Error in
                guard let errors = error as? [JSONAPIError] else { return NetworkAPIError.generic }
                return NetworkAPIError.responseErrors(errors: errors)
            }
            .eraseToAnyPublisher()
    }
}
