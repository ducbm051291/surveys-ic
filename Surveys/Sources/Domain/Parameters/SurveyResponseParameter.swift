//
//  SurveyResponseParameter.swift
//  Surveys
//
//  Created by David Bui on 03/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct SurveyResponseParameter: Parameterable, Codable, Equatable {

    struct QuestionResponseParameter: Parameterable, Codable, Equatable {

        let id: String
        let answers: [AnswerReponseParameter]

        struct AnswerReponseParameter: Parameterable, Codable, Equatable {

            let id: String
            let answer: String
        }
    }

    let surveyId: String
    let questions: [QuestionResponseParameter]

    init(surveyId: String, questions: [QuestionResponse]) {
        self.surveyId = surveyId
        self.questions = questions.map { question in
            QuestionResponseParameter(
                id: question.id,
                answers: question.answers.map { answer in
                    QuestionResponseParameter.AnswerReponseParameter(
                        id: answer.id,
                        answer: answer.answer
                    )
                }
            )
        }
    }

    static func == (lhs: SurveyResponseParameter, rhs: SurveyResponseParameter) -> Bool {
        lhs.surveyId == rhs.surveyId
    }
}
