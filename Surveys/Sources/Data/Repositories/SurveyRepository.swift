//
//  SurveyRepository.swift
//  Surveys
//
//  Created by David Bui on 19/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyRepository: SurveyRepositoryProtocol {

    @Injected private var networkAPI: NetworkAPIProtocol
    @Injected private var surveyCache: SurveyCache

    func getSurveyDetail(id: String) -> Observable<Survey> {
        networkAPI.performRequest(.surveyDetail(id), for: APISurvey.self)
            .map { $0 as Survey }
            .asObservable()
    }

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        networkAPI.performRequest(.surveyList(pageNumber, pageSize), for: [APISurvey].self)
            .map {
                self.surveyCache.set($0)
                return $0
            }
            .map { $0 as [Survey] }
            .replaceError(with: surveyCache.get() ?? [])
            .asObservable()
    }
}
