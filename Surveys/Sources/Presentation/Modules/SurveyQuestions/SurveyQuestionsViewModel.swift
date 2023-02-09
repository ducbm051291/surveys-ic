//
//  SurveyQuestionsViewModel.swift
//  Surveys
//
//  Created by David Bui on 05/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyQuestionsViewModel: ObservableObject {

    @Injected private var submitSurveyResponseUseCase: SubmitSurveyResponseUseCaseProtocol
    @Injected private var getQuestionResponseUseCase: GetQuestionResponseUseCaseProtocol
    @Injected private var clearQuestionResponseUseCase: ClearQuestionResponseUseCaseProtocol

    @Published var state: State = .idle
    @Published var survey: Survey
    @Published var questions: [SurveyQuestionViewModel]

    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init(survey: Survey) {
        self.survey = survey
        let surveyQuestions = survey.questions ?? []
        questions = surveyQuestions.map {
            SurveyQuestionViewModel(
                question: $0,
                numberOfQuestion: surveyQuestions.count
            )
        }

        let errorState = errorTracker
            .catchError()
            .map { State.error($0) }

        let loadingState = activityTracker
            .filter { $0 }
            .map { _ in State.submitting }

        Publishers.Merge(errorState, loadingState)
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)

        clearQuestionResponse()
    }

    func clearQuestionResponse() {
        questions.forEach { clearQuestionResponseUseCase.execute(id: $0.question.id) }
    }

    func submitQuestionResponse() {
        let questionResponses = questions.map { $0.question.id }
            .compactMap { getQuestionResponseUseCase.execute(id: $0) }

        submitSurveyResponseUseCase
            .execute(
                surveyId: survey.id,
                questions: questionResponses
            )
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .asDriver()
            .map { _ in State.submitted }
            .assign(to: &$state)
    }
}

extension SurveyQuestionsViewModel {

    enum State: Equatable {

        case idle, submitting, submitted
        case error(String)
    }
}
