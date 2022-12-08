//
//  APIMessage.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIMessage: Message, Decodable, Equatable {

    var message: String
}
