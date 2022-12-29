//
//  APISurvey.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APISurvey: Survey, Codable, Equatable {

    let id: String
    let type: String
    let title: String
    let description: String
    let coverImageUrl: String
    var questionList: [APIQuestion]?
    var questions: [Question]? { questionList }
}

extension APISurvey {

    enum CodingKeys: String, CodingKey {

        case id, type, title, description, coverImageUrl
        case questionList = "questions"
    }
}

extension APISurvey {

    struct APIQuestion: Question, Codable, Equatable {

        struct APIAnswer: Answer, Codable, Equatable {

            let id: String
            let type: String
            let displayOrder: Int
            let text: String?
            let inputMaskPlaceholder: String?
        }

        let id: String
        let type: String
        let displayOrder: Int
        let displayType: String
        let text: String
        let pick: PickType
        let coverImageUrl: String
        var answerList: [APIAnswer]?
        var answers: [Answer]? { answerList }

        enum CodingKeys: String, CodingKey {

            case id, text, pick, type, displayOrder, displayType, coverImageUrl
            case answerList = "answers"
        }
    }
}
