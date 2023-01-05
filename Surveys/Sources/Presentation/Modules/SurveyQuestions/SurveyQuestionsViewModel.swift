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

    @Published var state: State = .idle
    @Published var survey: Survey

    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init(survey: Survey) {
        self.survey = survey

        let errorState = errorTracker
            .catchError()
            .map { State.error($0) }

        let loadingState = activityTracker
            .filter { $0 }
            .map { _ in State.submitting }

        Publishers.Merge(errorState, loadingState)
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }

    func loadSurveyDetail() {
        let submitSurveyResponse = submitSurveyResponseUseCase
            .execute(survey: survey)
            .trackError(errorTracker)
            .trackActivity(activityTracker)
            .asDriver()
            .share()

        submitSurveyResponse
            .map { _ in
                State.submitted
            }
            .assign(to: &$state)
    }
}

extension SurveyQuestionsViewModel {

    enum State: Equatable {

        case idle, submitting, submitted
        case error(String)
    }
}