//
//  APIAnswerResponse.swift
//  Surveys
//
//  Created by David Bui on 09/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct APIAnswerResponse: Codable {

    let id: String
    let answer: String

    init(answerResponse: AnswerResponse) {
        id = answerResponse.id
        answer = answerResponse.answer
    }
}
