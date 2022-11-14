//
//  JSONAPIDecoder+Default.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import JSONAPIMapper

extension JSONAPIDecoder {

    static let `default`: JSONAPIDecoder = {
        let decoder = JSONAPIDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.iso8601WithoutTimeZone)
        return decoder
    }()
}
