//
//  QuestionResponseParameter.swift
//  Surveys
//
//  Created by David Bui on 03/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct QuestionResponseParameter: Codable {

    let id: String
    let answers: [AnswerResponseParameter]
}
