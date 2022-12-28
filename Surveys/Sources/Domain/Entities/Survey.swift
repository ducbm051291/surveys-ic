//
//  Survey.swift
//  Surveys
//
//  Created by David Bui on 13/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Survey {

    var id: String { get }
    var type: String { get }
    var title: String { get }
    var description: String { get }
    var coverImageUrl: String { get }
    var questionList: [Question]? { get }
}
