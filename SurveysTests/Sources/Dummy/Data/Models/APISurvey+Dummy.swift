//
//  APISurvey+Dummy.swift
//  SurveysTests
//
//  Created by David Bui on 20/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Surveys

extension APISurvey {

    static let dummy = APISurvey(
        id: "1",
        type: "customer satisfaction",
        title: "How was your experience with us?",
        description: "We would love to hear your feedback.",
        coverImageUrl: "https://example.com/cover-image.jpg",
        questionList: [
            APISurvey.APIQuestion(
                id: "1",
                type: "single-choice",
                displayOrder: 1,
                displayType: .choice,
                text: "How would you rate our customer service?",
                pick: .one,
                coverImageUrl: "https://example.com/cover-image.jpg",
                answerList: [
                    APISurvey.APIQuestion.APIAnswer(
                        id: "1",
                        type: "option",
                        displayOrder: 1,
                        text: "Excellent",
                        inputMaskPlaceholder: nil
                    ),
                    APISurvey.APIQuestion.APIAnswer(
                        id: "2",
                        type: "option",
                        displayOrder: 2,
                        text: "Good",
                        inputMaskPlaceholder: nil
                    ),
                    APISurvey.APIQuestion.APIAnswer(
                        id: "3",
                        type: "option",
                        displayOrder: 3,
                        text: "Average",
                        inputMaskPlaceholder: nil
                    ),
                    APISurvey.APIQuestion.APIAnswer(
                        id: "4",
                        type: "option",
                        displayOrder: 4,
                        text: "Poor",
                        inputMaskPlaceholder: nil
                    ),
                    APISurvey.APIQuestion.APIAnswer(
                        id: "5",
                        type: "option",
                        displayOrder: 5,
                        text: "Very Poor",
                        inputMaskPlaceholder: nil
                    )
                ]
            ),
            APISurvey.APIQuestion(
                id: "2",
                type: "open-ended",
                displayOrder: 2,
                displayType: .textfield,
                text: "What can we do to improve?",
                pick: .one,
                coverImageUrl: "",
                answerList: []
            )
        ]
    )
}
