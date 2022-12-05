//
//  MetaDecodable.swift
//  Surveys
//
//  Created by David Bui on 05/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol MetaDecodable {

    associatedtype Meta: Decodable

    var meta: Meta { get }
}
