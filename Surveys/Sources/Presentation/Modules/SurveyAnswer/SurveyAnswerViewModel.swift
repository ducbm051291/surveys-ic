//
//  SurveyAnswerViewModel.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Foundation

final class SurveyAnswerViewModel: ObservableObject {

    @Published var answers: [Answer]

    init(answers: [Answer]) {
        self.answers = answers
    }
}
