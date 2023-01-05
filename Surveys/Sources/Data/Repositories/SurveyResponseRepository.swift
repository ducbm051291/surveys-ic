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

    func submitResponse(_ survey: Survey) -> Observable<NoReply> {
        let questions = survey.questions.map { questions in
            questions.map { question in
                QuestionResponseParameter(
                    id: question.id,
                    answers: question.answers.map { answers in
                        answers.map { answer in
                            AnswerResponseParameter(
                                id: answer.id,
                                answer: answer.answer ?? .empty
                            )
                        }
                    } ?? []
                )
            }
        }
        let parameter = SurveyResponseParameter(
            surveyId: survey.id,
            questions: questions ?? []
        )
        return networkAPI.performRequest(.surveyResponse(parameter), for: APINoReply.self)
            .map { $0 as NoReply }
            .asObservable()
    }
}
