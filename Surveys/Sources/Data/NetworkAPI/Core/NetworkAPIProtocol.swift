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

    func performRequest<T: Decodable>(_ request: APIRequest) -> Observable<T>
}

extension NetworkAPIProtocol {

    func request<T: Decodable>(
        _ request: APIRequest,
        provider: MoyaProvider<APIRequest>,
        decoder: JSONDecoder
    ) -> Observable<T> {
        return provider.requestPublisher(request)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
