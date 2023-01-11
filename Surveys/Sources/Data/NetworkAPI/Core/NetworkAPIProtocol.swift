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
