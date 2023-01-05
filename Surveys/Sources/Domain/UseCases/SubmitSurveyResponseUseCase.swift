//
//  SubmitSurveyResponseUseCase.swift
//  Surveys
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol SubmitSurveyResponseUseCaseProtocol {

    func execute(survey: Survey) -> Observable<Void>
}

final class SubmitSurveyResponseUseCase: SubmitSurveyResponseUseCaseProtocol {

    @Injected private var surveyResponseRepository: SurveyResponseRepositoryProtocol

    func execute(survey: Survey) -> Observable<Void> {
        surveyResponseRepository.submitResponse(survey)
    }
}
