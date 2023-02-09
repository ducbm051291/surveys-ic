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
        questionList: APISurvey.APIQuestion.dummyList
    )
}
