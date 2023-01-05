//
//  SurveyQuestionViewModel.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyQuestionViewModel: ObservableObject {

    @Published var question: Question
    @Published var answerViewModel: SurveyAnswerViewModel
    @Published var questionIndex: String = .empty
    @Published var questionText: String = .empty

    init(question: Question, numberOfQuestion: Int) {
        self.question = question
        answerViewModel = SurveyAnswerViewModel(answers: question.answers ?? [])
        questionIndex = "\(question.displayOrder + 1)/\(numberOfQuestion)"
        questionText = question.text
    }
}
