//
//  APIQuestion+Dummy.swift
//  SurveysTests
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

@testable import Surveys

extension APISurvey.APIQuestion {

    static let dummyList = [
        APISurvey.APIQuestion(
            id: "940d229e4cd87cd1e202",
            type: "question",
            displayOrder: 1,
            displayType: .star,
            text: "Food â€“ Variety, Taste and Presentation",
            pick: .one,
            coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_"
        ),
        APISurvey.APIQuestion(
            id: "c3a9b8ce5c2356010703",
            type: "question",
            displayOrder: 9,
            displayType: .textarea,
            text: "Your additional comments are welcomed.",
            pick: .none,
            coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/b41c84934fa8e4c34269_"
        )
    ]
}
