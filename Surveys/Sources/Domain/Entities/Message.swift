//
//  Message.swift
//  Surveys
//
//  Created by David Bui on 06/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Message: Decodable {

    var message: String { get }
}
