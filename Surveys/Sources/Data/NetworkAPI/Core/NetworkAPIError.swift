//
//  NetworkAPIError.swift
//  Surveys
//
//  Created by David Bui on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import JSONAPIMapper

enum NetworkAPIError: Error, Equatable {

    case generic
    case dataNotFound
    case responseErrors(errors: [JSONAPIError])
}
