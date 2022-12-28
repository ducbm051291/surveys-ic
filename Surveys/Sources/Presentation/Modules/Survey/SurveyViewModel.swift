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

    @Published var state: State = .idle
    @Published var survey: Survey

    init(survey: Survey) {
        self.survey = survey
    }
}

extension SurveyViewModel {

    enum State: Equatable {

        case idle, loading, loaded
        case error(String)
    }
}

