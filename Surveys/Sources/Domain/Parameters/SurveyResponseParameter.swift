//
//  SurveyResponseParameter.swift
//  Surveys
//
//  Created by David Bui on 03/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

struct SurveyResponseParameter: Parameterable, Codable, Equatable {

    let surveyId: String
    let questions: [APIQuestionResponse]

    init(surveyId: String, questions: [QuestionResponse]) {
        self.surveyId = surveyId
        self.questions = questions.map(APIQuestionResponse.init)
    }

    static func == (lhs: SurveyResponseParameter, rhs: SurveyResponseParameter) -> Bool {
        lhs.surveyId == rhs.surveyId
    }
}
