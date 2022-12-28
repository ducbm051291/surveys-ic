//
//  SurveyViewModel.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyViewModel: ObservableObject {

    @Injected private var getSurveyDetailUseCase: GetSurveyDetailUseCaseProtocol

    @Published var state: State = .idle
    @Published var survey: Survey

    private let errorTracker = ErrorTracker()
    private let activityTracker = ActivityTracker(false)

    init(survey: Survey) {
        self.survey = survey
    }

    func loadSurveyDetail() {
        state = .loading

        let getSurveyDetail = getSurveyDetailUseCase
            .execute(id: survey.id)
            .trackError(errorTracker)
            .asDriver()
            .share()

        getSurveyDetail
            .assign(to: &$survey)

        getSurveyDetail
            .map { _ in
                State.loaded
            }
            .assign(to: &$state)
    }
}

extension SurveyViewModel {

    enum State: Equatable {

        case idle, loading, loaded
        case error(String)
    }
}
