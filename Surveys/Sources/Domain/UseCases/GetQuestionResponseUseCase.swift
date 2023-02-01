//
//  GetQuestionResponseUseCase.swift
//  Surveys
//
//  Created by David Bui on 01/02/2023.
//  Copyright © 2023 Nimble. All rights reserved.
//


import Combine
import Foundation
import Resolver

// sourcery: AutoMockable
protocol GetQuestionResponseUseCaseProtocol {

    func execute(id: String) -> APIQuestionResponse?
}

struct GetQuestionResponseUseCase: GetQuestionResponseUseCaseProtocol {

    @Injected private var questionResponseCache: QuestionResponseCache

    func execute(id: String) -> APIQuestionResponse? {
        questionResponseCache.get(id: id)
    }
}
