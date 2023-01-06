//
//  SurveyResponseRepository.swift
//  Surveys
//
//  Created by David Bui on 04/01/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//

import Combine
import Foundation
import Resolver

final class SurveyResponseRepository: SurveyResponseRepositoryProtocol {

    @Injected(name: .jsonNetworkAPI) private var networkAPI: NetworkAPIProtocol

    func submitResponse(_ surveyId: String, questions: [APIQuestionResponse]) -> Observable<Void> {
        let parameter = SurveyResponseParameter(
            surveyId: surveyId,
            questions: questions
        )
        return networkAPI.performRequest(.surveyResponse(parameter), for: APINoReply.self)
            .map { _ in () }
            .asObservable()
    }
}
