//
//  APIEmpty.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIEmpty: MetaDecodable, Decodable, Equatable {

    static func == (lhs: APIEmpty, rhs: APIEmpty) -> Bool {
        lhs.meta.message == rhs.meta.message
    }

    var meta: MessageMeta
}
