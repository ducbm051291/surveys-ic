//
//  GetSurveyListUseCase.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Resolver

// sourcery: AutoMockable
protocol GetSurveyListUseCaseProtocol {

    func execute(pageNumber: Int, pageSize: Int) -> Observable<[Survey]>
}

final class GetSurveyListUseCase: GetSurveyListUseCaseProtocol {

    @Injected private var surveyRepository: SurveyRepositoryProtocol

    func execute(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        surveyRepository.getSurveyList(pageNumber: pageNumber, pageSize: pageSize)
    }
}
