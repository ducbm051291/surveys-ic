//
//  APIQuestion.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIQuestion: Question, Codable, Equatable {

    let id: String
    let type: String
    let displayOrder: Int
    let displayType: String
    let text: String
    let pick: PickType
    let coverImageUrl: String
    var answerList: [APIAnswer]?
    var answers: [Answer]? { answerList }
}

extension APIQuestion {

    enum CodingKeys: String, CodingKey {

        case id, text, pick, type, displayOrder, displayType, coverImageUrl
        case answerList = "answers"
    }
}
