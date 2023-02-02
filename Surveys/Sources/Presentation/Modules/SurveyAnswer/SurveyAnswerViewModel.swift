//
//  SurveyAnswerViewModel.swift
//  Surveys
//
//  Created by David Bui on 01/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyAnswerViewModel: ObservableObject {

    @Injected private var storeQuestionResponseUseCase: StoreQuestionResponseUseCaseProtocol

    @Published var displayType: DisplayType = .smiley
    @Published var pickType: PickType = .none
    @Published var answers: [Answer] = []
    @Published var responses: [AnswerResponse] = []

    private var questionId: String

    init(question: Question) {
        questionId = question.id
        displayType = question.displayType
        pickType = question.pick
        answers = question.answers ?? []
    }

    func answer(_ index: Int, text: String = .empty) {
        guard answers.count > index else {
            return
        }
        let isMultipleChoice = displayType == .choice && pickType == .any || displayType == .textfield
        if isMultipleChoice {
            let answer = answers[index]
            if let selectedAnswerIndex = responses.firstIndex(where: { $0.id == answer.id }) {
                if displayType == .choice {
                    responses.remove(at: selectedAnswerIndex)
                } else {
                    responses[selectedAnswerIndex].answer = text
                }
            } else {
                responses.append(AnswerResponse(id: answers[index].id, answer: .empty))
            }
        } else {
            responses = [AnswerResponse(id: answers[index].id, answer: .empty)]
        }
        storeAnswerResponses()
    }
}

extension SurveyAnswerViewModel {

    private func storeAnswerResponses() {
        storeQuestionResponseUseCase.execute(questionResponse: QuestionResponse(
            id: questionId,
            answers: responses
        ))
    }
}
