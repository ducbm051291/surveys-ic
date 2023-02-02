//
//  QuestionResponse+Dummy.swift
//  SurveysTests
//
//  Created by David Bui on 02/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

@testable import Surveys

extension QuestionResponse {

    static let dummy = QuestionResponse(
        id: "940d229e4cd87cd1e202",
        answers: [AnswerResponse](repeating: AnswerResponse.dummy, count: 3)
    )
}
