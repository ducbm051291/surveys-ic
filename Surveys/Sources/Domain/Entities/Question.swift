//
//  Question.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Question {

    var id: String { get }
    var type: String { get }
    var displayOrder: Int { get }
    var displayType: String { get }
    var text: String { get }
    var pick: PickType { get }
    var coverImageUrl: String { get }
    var answers: [Answer]? { get }
}
