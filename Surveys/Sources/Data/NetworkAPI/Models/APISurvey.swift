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
}
