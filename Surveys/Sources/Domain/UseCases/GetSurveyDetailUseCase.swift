//
//  GetSurveyDetailUseCase.swift
//  Surveys
//
//  Created by David Bui on 28/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol GetSurveyDetailUseCaseProtocol {

    func execute(id: String) -> Observable<Survey>
}

final class GetSurveyDetailUseCase: GetSurveyDetailUseCaseProtocol {

    @Injected private var surveyRepository: SurveyRepositoryProtocol

    func execute(id: String) -> Observable<Survey> {
        surveyRepository.getSurveyDetail(id: id)
    }
}
