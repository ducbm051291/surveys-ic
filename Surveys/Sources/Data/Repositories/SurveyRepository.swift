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

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Driver<[Survey]> {
        networkAPI.performRequest(.surveyList(pageNumber, pageSize), for: [APISurvey].self)
            .handleEvents(receiveOutput: { [weak self] surveys in
                self?.surveyCache.set(surveys)
            })
            .map { $0 as [Survey] }
            .replaceError(with: surveyCache.get() ?? [])
            .asDriver()
    }
}
