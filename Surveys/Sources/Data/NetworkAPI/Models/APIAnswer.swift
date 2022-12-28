//
//  APIAnswer.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIAnswer: Answer, Codable, Equatable {

    let id: String
    let type: String
    let displayOrder: Int
    let text: String?
    let inputMaskPlaceholder: String?
}
