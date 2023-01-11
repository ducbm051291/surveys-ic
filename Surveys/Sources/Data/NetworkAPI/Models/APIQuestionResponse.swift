//
//  APIQuestionResponse.swift
//  Surveys
//
//  Created by David Bui on 09/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct APIQuestionResponse: Codable {

    let id: String
    let answers: [APIAnswerResponse]

    init(questionResponse: QuestionResponse) {
        id = questionResponse.id
        answers = questionResponse.answers.map(APIAnswerResponse.init)
    }
}
