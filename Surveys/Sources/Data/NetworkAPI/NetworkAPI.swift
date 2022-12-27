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

final class NetworkAPI: NetworkAPIProtocol {

    private let provider = MoyaProvider<RequestConfiguration>(plugins: [AuthPlugin()])
    private let decoder: JSONAPIDecoder

    init(decoder: JSONAPIDecoder = JSONAPIDecoder.default) {
        self.decoder = decoder
    }

    func performRequest<T>(
        _ configuration: RequestConfiguration,
        for type: T.Type
    ) -> Observable<T> where T: Decodable {
        request(configuration, provider: provider, decoder: JSONAPIDecoder.default)
    }
}
